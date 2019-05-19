class Rankings::FreeAppsController < RankingsController
  def index
    @apps = get_app_ranking_data(country: params[:country], type: 'top-free', limit: 200)
    @countries = Country.all.order(name: :asc)
  end
end
