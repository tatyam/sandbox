class InsertInitialCities < ActiveRecord::Migration[7.0]
  def change
    cities = [
      { name: '東京', en_name: 'Tokyo', country: 'JP', latitude: 35.6828387, longitude: 139.7594549 },
      { name: '札幌', en_name: 'Sapporo', country: 'JP', latitude: 43.061936, longitude: 141.3542924 },
      { name: '仙台', en_name: 'Sendai', country: 'JP', latitude: 38.2677554, longitude: 140.8691498 },
      { name: '名古屋', en_name: 'Nagoya', country: 'JP', latitude: 35.1851045, longitude: 136.8998438 },
      { name: '金沢', en_name: 'Kanazawa', country: 'JP', latitude: 36.561627, longitude: 136.6568822 },
      { name: '大阪', en_name: 'Osaka', country: 'JP', latitude: 34.6937569, longitude: 135.5014539 },
      { name: '広島', en_name: 'Hiroshima', country: 'JP', latitude: 34.3916058, longitude: 132.4518156 },
      { name: '松山', en_name: 'Matsuyama', country: 'JP', latitude: 33.8395188, longitude: 132.7653521 },
      { name: '福岡', en_name: 'Fukuoka', country: 'JP', latitude: 33.5898988, longitude: 130.4017509 },
      { name: '鹿児島', en_name: 'Kagoshima', country: 'JP', latitude: 31.5841689, longitude: 130.543387 },
      { name: '那覇', en_name: 'Naha', country: 'JP', latitude: 26.2122345, longitude: 127.6791452 }
    ]
    cities.each do |c|
      City.create(c)
    end
  end
end
