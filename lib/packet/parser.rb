# This workaround is until we have a solution for https://github.com/remiprev/her/issues/375
module Packet
  class Parser < Faraday::Response::Middleware
    KEYS = [:user, :devices, :projects, :ssh_keys, :members, :memberships, :invitations, :payment_method]
    def on_complete(env)
      @env = env
      clean_data
    end

    private

    def clean_data
      data.tap do |response|
        if collection?
          response[resource_slug].each { |entity| clean entity }
        else
          clean response
        end
      end
    end

    def clean(entity)
      entity.delete_if do |key, _|
        # TODO: do not delete if it was included in the query string
        KEYS.include?(key)
      end
    end

    def collection?
      data.key?(resource_slug)
    end

    def resource_slug
      @env[:url].path.split('/').last.underscore.to_sym
    end

    def data
      @env[:body][:data]
    end

    def valid?
      data
    end
  end
end
