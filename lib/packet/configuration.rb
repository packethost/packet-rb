module Packet
  class Configuration
    include ActiveModel::Model
    include ActiveModel::Validations

    API_URL   = 'https://api.packet.net'.freeze
    MIME_JSON = 'application/json'.freeze

    attr_accessor :auth_token, :consumer_token, :url

    validates :auth_token, presence: true

    def faraday_options
      return {
        url: url || API_URL,
        headers: headers,
        ssl: { verify: true }
      }
    end

    private

    def headers
      fail InvalidConfiguration unless valid?
      {
        'X-Consumer-Token' => consumer_token,
        'X-Auth-Token'     => auth_token,
        'Content-Type'     => MIME_JSON,
        'Accept'           => MIME_JSON
      }.reject { |_, v| v.nil? }
    end
  end

  InvalidConfiguration = Class.new(RuntimeError)
end
