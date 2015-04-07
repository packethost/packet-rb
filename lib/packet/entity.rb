module Packet
  class Entity
    def initialize(attributes = {})
      attributes.each_pair do |attribute, value|
        setter = "#{attribute}="
        send(setter, value) if respond_to?(setter)
      end
    end

    def client
      self.class.client
    end

    def self.client
      Packet::Client.instance
    end
  end
end
