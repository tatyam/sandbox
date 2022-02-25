require 'net/http'

module Communicator
  ERROR_HASH = { code: 999, message: 'access_error', body: 'undefined method.' }

  class << self
    def access(method, url, params={}, headers={})
      # Get・Post以外はエラーとする
      return ERROR_HASH unless %i(get post).include?(method)

      # URI parse
      uri = URI.parse(url)
      Rails.logger.debug "scheme: #{uri.scheme}"
      Rails.logger.debug "host: #{uri.host}"
      Rails.logger.debug "port: #{uri.port}"
      Rails.logger.debug "request_uri: #{uri.request_uri}"

      # HTTPオブジェクト作成
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')

      # request作成
      req = nil
      if method == :get
        # paramsをquery-stringにする
        query = URI.encode_www_form(params)
        Rails.logger.debug "query: #{query}"
        req = Net::HTTP::Get.new("#{uri.request_uri}?#{query}")
      else # post
        req = Net::HTTP::Post.new(uri.request_uri)
        Rails.logger.debug "params: #{params}"
        req.set_form_data(params)
      end

      # header設定
      headers.each { |k,v| req.add_field(k, v) }

      # 通信実施
      res = http.request(req)

      Rails.logger.debug res.inspect
      { code: res.code, message: res.message, body: res.body }
    end
  end
end
