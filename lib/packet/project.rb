module Packet
  class Project
    include Entity

    attr_accessor :name

    has_many :devices
    has_timestamps
  end
end
