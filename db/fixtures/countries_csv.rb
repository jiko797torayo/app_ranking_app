require 'csv'

csv = CSV.read('db/fixtures/countries.csv')
csv.each do |col|
  id = col[0]
  name = col[1]
  code = col[2]

  Country.seed(:id) do |industry|
    industry.id = id
    industry.name = name
    industry.code = code
  end
end
