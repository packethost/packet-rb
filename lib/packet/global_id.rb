module Packet
  class GlobalIDLocator
    def locate(gid)
      gid.model_class.send :find, gid.model_id
    end
  end
end
