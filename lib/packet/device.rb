module Packet
  class Device < Entity
    include Mutable

    collection_path '/devices'

    def events
      @client.get("#{self.class.collection_path}/#{id}/events")
    end

    def lock
      post_action :lock
    end

    def power_off
      post_action :power_off
    end

    def power_on
      post_action :power_on
    end

    def reboot
      post_action :reboot
    end

    def rebuild
      post_action :rebuild
    end

    def unlock
      post_action :unlock
    end

    def update_hostname(hostname)
      @client.patch("#{self.class.collection_path}/#{id}", { 'hostname' => hostname })
    end

    private

    def post_action(action)
      @client.post("#{self.class.collection_path}/#{id}/actions", { 'type' => action.to_s })
    end
  end
end
