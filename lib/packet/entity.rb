require 'active_support/core_ext/class/attribute'
require 'active_support/inflector'

module Packet
  class Entity
    DEFAULT_TIMESTAMPS = [:created_at, :updated_at].freeze

    class_attribute :_casts
    self._casts = {}

    def initialize(attributes = {})
      attributes.each_pair do |attribute, value|
        setter = "#{attribute}="
        send(setter, _cast_value(attribute, value)) if respond_to?(setter)
      end
    end

    private

    def self.has_one(association)
      casts(association, lambda do |value|
        klass = "Packet::#{association.to_s.classify}".constantize
        klass.new(value)
      end)
    end

    def self.has_many(association)
      casts(association, lambda do |value|
        klass = "Packet::#{association.to_s.classify}".constantize
        value.map { |v| klass.new(v) }
      end)
    end

    def self.has_timestamps(timestamps = DEFAULT_TIMESTAMPS)
      timestamps.each { |timestamp| casts(timestamp, ->(value) { Time.parse(value) }) }
    end

    def self.casts(attribute, transformer)
      _casts[attribute.to_sym] = transformer
      attr_accessor attribute.to_sym
    end

    def _cast_value(attribute, value)
      if self.class._casts.key?(attribute.to_sym)
        self.class._casts[attribute.to_sym].call(value)
      else
        value
      end
    end
  end
end
