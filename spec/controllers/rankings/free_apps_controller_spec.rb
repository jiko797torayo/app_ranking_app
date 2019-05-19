require'rails_helper'
RSpec.describe Rankings::FreeAppsController, type: :controller do
  describe '#index' do
    it '正常にレスポンスを返す' do
      get :index
      expect(response).to be_success
    end
  end
end
