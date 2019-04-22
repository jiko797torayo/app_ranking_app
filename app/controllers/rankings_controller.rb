class RankingsController < ApplicationController
  def index
    @apps = StoreApi::AppStore::Apps::Ranking.new('topfreeapplications', '36', 'JP', 10).topchart
  end
end

