require 'faraday'
require 'faraday_middleware'
require 'packet/client/devices'
require 'packet/client/operating_systems'
require 'packet/client/plans'
require 'packet/client/projects'

module Packet
  class Client
    attr_accessor :url, :consumer_token, :auth_token

    def initialize(url = Packet.configuration.url,
                   auth_token = Packet.configuration.auth_token,
                   consumer_token = Packet.configuration.consumer_token)
      self.url = url
      self.auth_token = auth_token
      self.consumer_token = consumer_token
    end

    [:get, :post, :patch, :head, :delete].each do |method|
      define_method(method) do |*args|
        response = client.send(method, *args)
        fail_on_error(response) || response
      end
    end

    def self.instance
      @_instance ||= new
    end

    private

    def client
      @client ||= Faraday.new(url: url, headers: headers, ssl: { verify: true }) do |faraday|
        faraday.request :url_encoded
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    def headers
      {
        'X-Consumer-Token' => consumer_token,
        'X-Auth-Token' => auth_token,
        # 'X-Packet-Staff' => '1',
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }.reject { |_, v| v.nil? }
    end

    def fail_on_error(response)
      fail Error, response.body unless response.success?
    end

    include Packet::Client::Devices
    include Packet::Client::Projects
    include Packet::Client::Plans
    include Packet::Client::OperatingSystems
  end
end
