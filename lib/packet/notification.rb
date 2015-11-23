module Packet
  class Notification < Entity
    collection_path '/notifications'

    def mark_read
      @client.patch("#{self.class.collection_path}/#{id}", { 'read' => true })
    end
  end
end
