module Packet
  class Client
    module Plans
      def plans(*args)
        get('plans', *args).body['plans'].map { |p| Packet::Plan.new(p) }
      end
    end
  end
end
