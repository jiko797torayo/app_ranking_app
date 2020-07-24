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
    @current_genre = params[:genre] || 'all'
  end

  def current_condition 
    {
      country: @current_country,
      product: @current_product,
      type: @current_type,
      genre: @current_genre
    }
  end

  def products(country:, product:, type:, genre:)
    uri = URI.parse("https://rss.itunes.apple.com/api/v1/#{country}/#{product}/#{type}/#{genre}/200/explicit.json")
    json = Net::HTTP.get(uri)
    JSON.parse(json)['feed']['results']
  end

  def csv_filename(country:, product:, type:, genre:)
    File.basename("#{Time.zone.today.strftime('%Y%m%d')}_#{country}_#{product}_#{type}_#{genre}_ranking.csv".underscore)
  end
end
