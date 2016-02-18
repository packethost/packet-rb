module Packet
  class Device
    include Entity

    attr_accessor :hostname, :iqn, :ip_addresses, :tags, :userdata
    has_one :operating_system
    has_one :plan
    has_one :facility
    has_one :project
    has_timestamps

    def tags
      @tags ||= []
    end

    def ip_addresses
      @ip_addresses ||= []
    end
  end
end
