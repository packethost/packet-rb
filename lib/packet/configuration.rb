require 'her'

module Packet
  class Configuration
    include ActiveModel::Model
    include ActiveModel::Validations

    API_URL = 'https://api.packet.net'.freeze

    MIDDLEWARE = [
      Packet::ErrorHandler, Packet::Parser, Faraday::Request::UrlEncoded,
      Her::Middleware::AcceptJSON, Her::Middleware::DefaultParseJSON,
      Faraday::Adapter::NetHttp
    ].freeze

    attr_accessor :auth_token

    validates :auth_token, presence: true

    def setup(api = Her::API)
      fail InvalidConfiguration unless valid?
      api.setup url: API_URL, headers: headers, ssl: { verify: true } do |c|
        MIDDLEWARE.each { |middleware| c.use middleware }
      end
    end

    def new_api
      setup(Her::API.new)
    end

    private

    def headers
      {
        'X-Auth-Token' => auth_token
      }
    end

    InvalidConfiguration = Class.new(RuntimeError)
  end
end
