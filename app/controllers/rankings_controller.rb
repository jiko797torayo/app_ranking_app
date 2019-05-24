class RankingsController < ApplicationController
  require 'net/http'
  layout 'rankings'

  def get_products_ranking_data(country:, product:, type:, limit:)
    country ||= 'US'
    uri = URI.parse("https://rss.itunes.apple.com/api/v1/#{country}/#{product}/#{type}/all/#{limit}/explicit.json")
    json = Net::HTTP.get(uri)
    JSON.parse(json)['feed']['results']
  end
end
