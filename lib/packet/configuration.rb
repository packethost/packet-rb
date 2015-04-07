module Packet
  class Configuration
    attr_accessor :url, :consumer_token, :auth_token

    def initialize
      @url = 'https://api.packet.net'.freeze
    end
  end
end
