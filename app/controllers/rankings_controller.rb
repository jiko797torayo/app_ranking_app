class RankingsController < ApplicationController
  require 'net/http'
  layout 'rankings'

  def get_app_ranking_data(country:, type:, limit:)
    country ||= 'US'
    uri = URI.parse("https://rss.itunes.apple.com/api/v1/#{country}/ios-apps/#{type}/all/#{limit}/explicit.json")
    json = Net::HTTP.get(uri)
    JSON.parse(json)['feed']['results']
  end
end
