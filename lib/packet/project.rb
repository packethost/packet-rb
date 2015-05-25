require 'packet/entity'

module Packet
  class Project < Entity
    attr_accessor :id, :name

    has_many :ssh_keys
    has_many :devices
    has_timestamps
  end
end
