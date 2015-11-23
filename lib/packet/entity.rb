module Packet
  class Entity
    def initialize(client, id = nil)
      @client = client
      @attributes = {}
      @attributes[:id] = id if id
    end

    def id
      @attributes[:id]
    end

    def method_missing(method, *args)
      if @attributes.key?(method.to_sym)
        @attributes[method.to_sym]
      else
        super
      end
    end

    protected

    def self.collection_path(path = nil)
      if path.nil?
        @collection_path
      else
        @collection_path = path.freeze
      end
    end
  end
end
