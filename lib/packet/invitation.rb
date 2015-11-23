module Packet
  class Invitation < Entity
    collection_path '/invitations'

    def accept
      @client.patch("#{self.class.collection_path}/#{id}", {})
    end

    def decline
      @client.delete("#{self.class.collection_path}/#{id}")
    end
  end
end
