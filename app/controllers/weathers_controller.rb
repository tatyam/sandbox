class WeathersController < ApplicationController
  layout 'application'

  def index
    # 都市リスト
    @cities = Rails.cache.fetch('cache_cities', expired_in: 10.minutes) do
      City.active.order(id: :asc).all
    end
  end

  def show
    # 選択した都市の確認
    @city = City.find_by(id: params[:id])
    unless @city
      flash[:alert] = '都市の指定が不正です。'
      return redirect_to action: :index
    end

    # 現在の天気を取得
    api_response = ApiAccess::Openweathermap.get_current_weather(@city.latitude, @city.longitude)
    unless api_response[:cod] == 200
      flash.now[:alert] = "天気情報を取得できませんでした。 エラーコード：#{api_response[:cod]}"
      return render :show
    end

    # 使用する情報のみ取り出す
    @current_weather = {
      icon_id: api_response[:weather][0][:icon],
      description: api_response[:weather][0][:description],
      temp: api_response[:main][:temp],
      wind_speed: api_response[:wind][:speed],
      wind_deg: api_response[:wind][:deg]
    }
  end
end
