class Array
  require 'csv'
  def make_ranking_csv
    CSV.generate do |csv|
      column_names = %w(rank name category)
      csv << column_names
      self.each.with_index(1) do |app, i|
        column_values = [
          i,
          app['name'],
          app['genres'][0]['name']
        ]
        csv << column_values
      end
    end
  end
end
