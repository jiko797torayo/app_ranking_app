class RankingsController < ApplicationController
  require 'net/http'
  layout 'rankings'
  before_action :set_current_condition, only: [:index]

  def index
    @products = get_products_ranking_data(country: @current_country, product: @current_product, type: @current_type, limit: 200)
  rescue JSON::ParserError
    @products = []
  ensure
    @countries = Country.order(name: :asc)
  end

  private

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
