require 'her'

module Packet
  class Configuration
    include ActiveModel::Validations

    API_URL = 'https://api.packet.net'.freeze

    attr_accessor :auth_token

    validates! :auth_token, presence: true

    def setup
      Her::API.setup url: API_URL, headers: headers, ssl: { verify: true } do |c|
        c.use Packet::Parser

        c.use Faraday::Request::UrlEncoded

        c.use Her::Middleware::AcceptJSON

        c.use Her::Middleware::DefaultParseJSON

        c.use Faraday::Adapter::NetHttp
      end

      # This is very important. Due to way Her currently works
      # model files need to be required after configuring the API
      require_models
    end

    private

    def require_models
      %w(entity
         facility
         operating_system
         ssh_key
         project
         user
         plan
         device).each { |resource| require "packet/#{resource}" }
    end

    def headers
      {
        'X-Auth-Token' => auth_token
      }
    end
  end
end
