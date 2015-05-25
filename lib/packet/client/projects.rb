module Packet
  class Client
    module Projects
      def projects(*args)
        get('projects', *args).body['projects'].map { |p| Packet::Project.new(p) }
      end

      def project(id, *args)
        Packet::Project.new(get("projects/#{id}", *args).body)
      end
    end
  end
end
