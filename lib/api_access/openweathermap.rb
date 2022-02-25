module ApiAccess
  module Openweathermap
    API_URL = {
      search_geo_code: 'http://api.openweathermap.org/geo/1.0/direct',
      get_current_weather: 'https://api.openweathermap.org/data/2.5/weather'
    }.freeze

    class << self
      # 都市名から緯度・経度を取得
      def search_geo_code(city_en_name, country)
        result = Rails.cache.fetch("geo_code_#{city_en_name}_#{country}", expired_in: 1.day) do
          Communicator.access(:get, API_URL[:search_geo_code],
            { q: "#{city_en_name},#{country}", appid: API_KEYS[:openweathermap][:key],
              limit: 1 }
          )
        end

        # ステータスコードで判定
        if result[:code].to_i == 200
          res = JSON.parse(result[:body])
          # 配列が空の（都市が見つからない）場合はエラーを返す
          res.present? ? res.first.deep_symbolize_keys : { cod: 404, message: 'City does not found.' }
        else
          { cod: result[:code], message: 'API-Access Error.' }
        end
      end

      # 緯度・経度から現在の天気を取得
      def get_current_weather(latitude, longitude)
        result = Rails.cache.fetch("current_weather_#{latitude}_#{longitude}", expired_in: 1.hour) do
          Communicator.access(:get, API_URL[:get_current_weather],
            { lat: latitude, lon: longitude, appid: API_KEYS[:openweathermap][:key],
              mode: 'json', units: 'metric', lang: 'ja' }
          )
        end

        # ステータスコードで判定
        if result[:code].to_i == 200
          JSON.parse(result[:body]).deep_symbolize_keys
        else
          { cod: result[:code], message: 'API-Access Error.' }
        end
      end

      # 都市名から現在の天候を取得（will be deprecated soon）
      def get_current_weather_by_name(city_en_name, country)
        result = Rails.cache.fetch("current_weather_#{city_en_name}_#{country}", expired_in: 1.hour) do
          Communicator.access(:get, API_URL[:get_current_weather],
            { q: "#{city_en_name},#{country}", appid: API_KEYS[:openweathermap][:key],
              mode: 'json', units: 'metric', lang: 'ja' }
          )
        end

        # ステータスコードで判定
        if result[:code].to_i == 200
          JSON.parse(result[:body]).deep_symbolize_keys
        else
          { cod: result[:code], message: 'API-Access Error.' }
        end
      end
    end
  end
end
