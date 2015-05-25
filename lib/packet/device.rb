require 'packet/entity'

module Packet
  class Device < Entity
    attr_accessor :id, :name, :hostname, :ip_addresses, :userdata

    has_one :project
    has_one :facility
    has_one :plan

    has_timestamps

    def ip_addresses
      @ip_addresses || []
    end
  end
end
