require 'rails_helper'

RSpec.describe "Weathers", type: :request do
  describe "GET #index" do
    before do
      FactoryBot.create :tokyo
      FactoryBot.create :osaka
    end

    it "can succeed request" do
      get weathers_path
      expect(response.status).to eq 200
    end
    it 'can get cities' do
      get weathers_path
      expect(response.body).to include "東京"
      expect(response.body).to include "大阪"
    end
  end

  describe "GET #show" do
    before do
      FactoryBot.create :tokyo
      FactoryBot.create :osaka
    end

    it "can get weather when city exists" do
      get weather_path(1)
      expect(response.status).to eq 200
      expect(response.body).to include "東京の現在の天気"
    end

    it "redirects to index when city doesn't exists" do
      get weather_path(3)
      expect(response.status).to eq 302
    end
  end
end
