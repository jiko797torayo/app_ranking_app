class RankingsController < ApplicationController
  require 'net/http'
  layout 'rankings'

  def index
    @current_country = params[:country] || 'US'
    @current_product = params[:product] || 'ios-apps'
    @current_type = params[:type] || 'top-free'
    @products = products(current_condition)
  rescue JSON::ParserError
    @products = []
  ensure
    respond_to do |format|
      format.html do
        @countries = Country.order(name: :asc)
      end
      format.csv do
        file_name = File.basename("#{Time.zone.today.strftime('%Y%m%d')}_#{Country.find_by(code: @current_country).name.underscore}_#{@current_product.underscore}_#{@current_type.underscore}_ranking.csv")
        send_data @products.make_ranking_csv(@current_product),
                  type: 'text/csv; charset=shift_jis',
                  filename: file_name
      end
    end
  end

  private

  def products(country:, product:, type:)
    uri = URI.parse("https://rss.itunes.apple.com/api/v1/#{country}/#{product}/#{type}/all/200/explicit.json")
    json = Net::HTTP.get(uri)
    JSON.parse(json)['feed']['results']
  end

  def current_condition
    {
      country: @current_country,
      product: @current_product,
      type: @current_type
    }
  end
end
