module Packet
  class TransferRequest < Entity
    collection_path '/transfers'

    def accept
      @client.patch("#{self.class.collection_path}/#{id}", {})
    end

    def decline
      @client.delete("#{self.class.collection_path}/#{id}")
    end
  end
end
