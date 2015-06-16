require 'packet/entity'

module Packet
  class OperatingSystem < Entity
    attr_accessor :slug, :name, :distro, :version
  end
end
