class Rankings::FreeAppsController < RankingsController
  def index
    @apps = StoreApi::AppStore::Apps::Ranking.new('topfreeapplications', '36', params[:country], 10).topchart
    @countries = Country.all
  end
end

