require 'csv'

csv = CSV.read('db/fixtures/genres.csv')
csv.each do |col|
  id = col[0]
  number = col[1]
  name = col[2]
  product = col[3]

  Genre.seed(:id) do |industry|
    industry.id = id
    industry.number = number
    industry.name = name
    industry.product = product
  end
end
