require 'packet/entity'

module Packet
  class SshKey < Entity
    attr_accessor :id, :label, :key
    alias_method :to_s, :key

    has_one :user
  end
end
