module Packet
  class Client
    module Devices
      def devices(*args)
        get('devices', args).body['devices'].map { |p| Packet::Device.new(p) }
      end

      def device(id)
        Packet::Device.new(get("devices/#{id}").body)
      end
    end
  end
end
