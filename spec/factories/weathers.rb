FactoryBot.define do
  factory :tokyo, class: City do
    id { 1 }
    name { "東京" }
    en_name { "Tokyo" }
    country { "JP" }
  end

  factory :osaka, class: City do
    id { 2 }
    name { "大阪" }
    en_name { "Osaka" }
    country { "JP" }
  end
end
