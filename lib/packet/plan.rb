require 'packet/entity'

module Packet
  class Plan < Entity
    attr_accessor :name, :slug, :description
  end
end
