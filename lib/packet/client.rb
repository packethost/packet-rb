require 'active_support/inflector'

module Packet
  class Client
    ENTITIES = [:project, :device, :operating_system, :plan, :ssh_key, :user, :facility].freeze

    def initialize(auth_token)
      build_client auth_token
    end

    private

    def build_client(auth_token)
      api = Configuration.new(auth_token: auth_token).new_api
      ENTITIES.each do |entity|
        model = Class.new(packet_class(entity)) do
          root_element entity
          use_api api
        end

        self.class.send(:define_method, entity, -> { model })
      end
    end

    def packet_class(entity)
      "Packet::#{entity.to_s.classify}".constantize
    end
  end
end
