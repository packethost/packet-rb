require 'faraday'

module Packet
  class Client
    attr_accessor :url, :consumer_token, :auth_token

    def initialize(url, consumer_token, auth_token)
      self.url = url || Packet.configuration.url
      self.consumer_token = consumer_token || Packet.configuration.consumer_token
      self.auth_token = auth_token || Packet.configuration.auth_token
    end

    [:get, :post, :patch, :head, :delete].each do |method|
      define_method(method) do |*args|
        response = client.send(method, *args)
        fail_on_error(response) || response
      end
    end

    private

    def client
      @client ||= Faraday.new(url: host, headers: headers, ssl: true) do |faraday|
        faraday.request :url_encoded
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    def headers
      {
        'X-Consumer-Token' => consumer_token,
        'X-Auth-Token' => auth_token,
        'X-Packet-Staff' => '1',
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    def fail_on_error(response)
      fail Error, response.body unless response.success?
    end
  end
end
