module Packet
  class SshKey
    include Entity

    attr_accessor :label
    attr_accessor :key

    has_timestamps
  end
end
