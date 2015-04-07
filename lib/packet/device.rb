module Packet
  class Device
    include Entity

    attr_accessor :hostname

    has_timestamps
  end
end
