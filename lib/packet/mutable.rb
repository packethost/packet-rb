module Packet
  module Mutable
    undef_method :id=

    def delete
      @client.delete("#{self.class.collection_path}/#{id}")
    end

    def method_missing(method, *args)
      if method[-1] == '='
        @attributes[method[0..-2].to_sym] = args.first
      else
        super
      end
    end

    def save
      if id.nil?
        @client.post(self.class.collection_path, @attributes)
      else
        @client.patch("#{self.class.collection_path}/#{id}", @attributes)
      end
    end
  end
end
