module Packet
  class Client
    module SshKeys
      def list_ssh_keys(options = {})
        get('ssh-keys', options).body['ssh_keys'].map { |p| Packet::SshKey.new(p) }
      end
      alias_method :ssh_keys, :list_ssh_keys

      def get_ssh_key(id, options = {})
        Packet::SshKey.new(get("ssh-keys/#{id}", options).body)
      end
      alias_method :ssh_key, :get_ssh_key

      def create_ssh_key(label, key, options = {})
        parameters = { label: label, key: key }
        Packet::SshKey.new(post('ssh-keys', options.merge(parameters)).body)
      end

      def update_ssh_key(id, ssh_key, options = {})
        Packet::SshKey.new(patch("ssh-keys/#{id}", options.merge(ssh_key)).body)
      end

      def delete_ssh_key(id, options = {})
        delete("ssh-keys/#{id}", options).status == 204
      rescue Packet::Error
        false
      end
    end
  end
end
