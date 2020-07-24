require 'csv'
module CsvCommonModule
  extend ActiveSupport::Concern
  def make_ranking_csv
    CSV.generate do |csv|
      column_names = %w[rank name created_by category url]
      csv << column_names
      each.with_index(1) do |p, i|
        column_values = [
          i,
          p['name'],
          p['artistName'],
          p['genres'][0]['name'],
          p['url']
        ]
        csv << column_values
      end
    end
  end
end
