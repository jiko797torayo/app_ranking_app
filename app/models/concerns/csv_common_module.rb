require 'csv'
module CsvCommonModule
  extend ActiveSupport::Concern
  def make_ranking_csv(controller_name)
    case controller_name
    when 'free_apps', 'paid_apps'
      CSV.generate do |csv|
        column_names = %w[rank app_name category]
        csv << column_names
        each.with_index(1) do |product, i|
          column_values = [
            i,
            product['name'],
            product['genres'][0]['name']
          ]
          csv << column_values
        end
      end
    when 'itunes_musics'
      CSV.generate do |csv|
        column_names = %w[rank music_name artist_name]
        csv << column_names
        each.with_index(1) do |product, i|
          column_values = [
            i,
            product['name'],
            product['artistName']
          ]
          csv << column_values
        end
      end
    end
  end
end
