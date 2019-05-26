class RankingsController < ApplicationController
  require 'net/http'
  layout 'rankings'
  before_action :set_current_condition, only: [:index]

  def index
    begin
      @products = get_products_ranking_data(country: @current_country, product: @current_product, type: @current_type, limit: 200)
    rescue JSON::ParserError
      @products = []
    end
    respond_to do |format|
      format.html do
        @countries = Country.all.order(name: :asc)
      end
      format.csv do
        file_name = File.basename("#{Time.zone.today.strftime('%Y%m%d')}_#{Country.find_by(code: @current_country).name.underscore}_#{@current_product.underscore}_#{@current_type.underscore}_ranking.csv")
        send_data @products.make_ranking_csv(@current_product),
                  type: 'text/csv; charset=shift_jis',
                  filename: file_name
      end
    end
  end

  protected

  def get_products_ranking_data(country:, product:, type:, limit:)
    uri = URI.parse("https://rss.itunes.apple.com/api/v1/#{country}/#{product}/#{type}/all/#{limit}/explicit.json")
    json = Net::HTTP.get(uri)
    JSON.parse(json)['feed']['results']
  end

  def set_current_condition
    @current_country = params[:country] || 'US'
    @current_product = params[:product] || 'ios-apps'
    @current_type = params[:type] || 'top-free'
  end
end
