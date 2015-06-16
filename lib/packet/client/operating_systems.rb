module Packet
  class Client
    module OperatingSystems
      def operating_systems(*args)
        get('operating-systems', *args).body['operating_systems'].map { |p| Packet::OperatingSystem.new(p) }
      end
    end
  end
end
