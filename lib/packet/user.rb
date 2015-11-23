module Packet
  class User < Entity
    include Mutable

    collection_path '/users'
  end
end
