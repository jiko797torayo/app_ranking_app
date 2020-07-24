class RankingsController < ApplicationController
  require 'net/http'
  layout 'rankings'

  def index
    set_current_condition
    @products = products(current_condition)
  rescue JSON::ParserError
    @products = []
  ensure
    respond_to do |format|
      format.html do
        @countries = Country.order(name: :asc)
      end
      format.csv do
        file_name = csv_filename(current_condition)
        send_data @products.make_ranking_csv(@current_product),
                  type: 'text/csv; charset=utf-8',
                  filename: file_name
      end
    end
  end

  private

  def set_current_condition
    @current_country = params[:country] || 'US'
    @current_product = params[:product] || 'ios-apps'
    @current_type = params[:type] || 'top-free'
  end

  def current_condition 
    {
      country: @current_country,
      type: @current_type,
      product: @current_product
    }
  end

  def products(country:, product:, type:)
    uri = URI.parse("https://rss.itunes.apple.com/api/v1/#{country}/#{product}/#{type}/all/200/explicit.json")
    json = Net::HTTP.get(uri)
    JSON.parse(json)['feed']['results']
  end

  def csv_filename(country:, product:, type:)
    File.basename("#{Time.zone.today.strftime('%Y%m%d')}_#{country}_#{type}_#{product}_ranking.csv".underscore)
  end
end
