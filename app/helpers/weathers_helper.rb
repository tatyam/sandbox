module WeathersHelper
  # 天気アイコン
  def weather_icon(icon_id, description)
    image_tag("http://openweathermap.org/img/wn/#{icon_id}@2x.png", width: 80, height: 80, alt: description)
  end

  # 風の方角（数値→日本語に変換）
  def degree_name(deg)
    case deg
    when 23..67
      '北東'
    when 68..112
      '東'
    when 113..157
      '南東'
    when 158..202
      '南'
    when 203..247
      '南西'
    when 248..292
      '西'
    when 293..337
      '北西'
    else # 0～22・338～360
      '北'
    end
  end
end
