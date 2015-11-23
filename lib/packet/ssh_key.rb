module Packet
  class SSHKey < Entity
    include Mutable

    collection_path '/ssh-keys'
  end
end
