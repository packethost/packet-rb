module Packet
  class SshKey < Entity
    collection_path '/ssh-keys'
    resource_path '/ssh-keys/:id'
  end
end
