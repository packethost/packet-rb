require 'active_support/concern'

module Packet
  module Entity
    module Serialization
      extend ActiveSupport::Concern

      def to_hash
        instance_variables.reject { |ivar| [:@client].include?(ivar) }.map do |ivar|
          [ivar.to_s.tr('@', ''), instance_variable_get(ivar)]
        end.to_h
      end
      alias_method :to_h, :to_hash
    end
  end
end
