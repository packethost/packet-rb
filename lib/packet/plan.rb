module Packet
  class Plan
    include Entity

    attr_accessor :slug
    attr_accessor :name
    attr_accessor :description
    attr_accessor :line
    attr_accessor :specs
    attr_accessor :pricing
  end
end
