require 'csv'
module CsvCommonModule
  extend ActiveSupport::Concern
  def make_ranking_csv(current_product)
    case current_product
    when 'ios-apps'
      CSV.generate do |csv|
        column_names = %w[rank app_name category]
        csv << column_names
        each.with_index(1) do |p, i|
          column_values = [
            i,
            p['name'],
            p['genres'][0]['name']
          ]
          csv << column_values
        end
      end
    when 'itunes-music'
      CSV.generate do |csv|
        column_names = %w[rank music_name artist_name]
        csv << column_names
        each.with_index(1) do |p, i|
          column_values = [
            i,
            p['name'],
            p['artistName']
          ]
          csv << column_values
        end
      end
    end
  end
end
