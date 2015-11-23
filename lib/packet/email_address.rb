module Packet
  class EmailAddress < Entity
    collection_path '/emails'

    def mark_default
      @client.patch("#{self.class.collection_path}/#{id}", { 'default' => true })
    end
  end
end
