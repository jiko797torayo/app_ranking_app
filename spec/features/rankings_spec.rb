require 'rails_helper'

RSpec.feature 'Rankings', type: :feature do
  scenario 'ユーザーが各国のios無料アプリランキングのページを見る' do
    countries = Country.all
    countries.each do |country|
      p country.name
      visit root_path
      expect(page).to have_selector 'p', text: country.name
      click_link country.name
      expect(page).to have_selector 'p', text: Settings.rankings.ios_apps.top_free.title
    end
  end
end
