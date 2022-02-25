require 'rails_helper'

RSpec.describe "Top", type: :request do
  describe "GET #index" do
    it "can succeed request" do
      get root_path
      expect(response.status).to eq 200
    end
    it 'can display menu' do
      get root_path
      expect(response.body).to include "Menu"
    end
  end

end
