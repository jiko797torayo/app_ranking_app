class Rankings::FreeAppsController < RankingsController
  def index
    @apps = get_app_ranking_data(country: params[:country], type: 'top-free', limit: 200)
    respond_to do |format|
      format.html do
        @countries = Country.all.order(name: :asc)
        @current_country = params[:country]
      end
      format.csv do
        file_name = File.basename("#{Time.zone.today.strftime('%Y%m%d')}_free_apps_ranking")
        send_data @apps.make_ranking_csv,
                  type: 'text/csv; charset=shift_jis',
                  filename: file_name
      end
    end
  end
end
