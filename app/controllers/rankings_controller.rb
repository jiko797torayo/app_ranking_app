class RankingsController < ApplicationController
  layout 'rankings'

  def get_app_ranking_data(country: 'us', type:, limit:)
    uri = URI.parse("https://rss.itunes.apple.com/api/v1/#{country}/ios-apps/#{type}/all/#{limit}/explicit.json")
    json = Net::HTTP.get(uri)
    JSON.parse(json)['feed']['results']
  end
end
