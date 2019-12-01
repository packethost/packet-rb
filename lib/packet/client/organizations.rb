module Packet
  class Client
    module Organizations
      def list_organizations(*args)
        get('organizations', *args).body['organizations'].map { |p| Packet::Organization.new(p, self) }
      end
    end
  end
end
