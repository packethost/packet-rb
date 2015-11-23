module Packet
  class Project < Entity
    include Mutable

    collection_path '/projects'

    def create_device(hostname, opts = {})
      body = {
        'hostname' => hostname
      }
      @client.post("#{self.class.collection_path}/#{id}/devices", body)
    end

    def events
      @client.get("#{self.class.collection_path}/#{id}/events")
    end

    def invite_user(id_or_email, roles = nil, message = nil)
      case roles
      when nil
        roles = ['collaborator']
      when Array
        # TODO(betawaffle): Validate the given roles.
        roles = roles.map { |role| role.to_s }
      else
        raise TypeError, 'roles should be an Array'
      end

      body = {
        'user'  => id_or_email,
        'roles' => roles,
      }
      body['message'] = message if message

      @client.post("#{self.class.collection_path}/#{id}/invitations", body)
    end

    def request_transfer
      @client.post("#{self.class.collection_path}/#{id}/transfers", {})
    end
  end
end
