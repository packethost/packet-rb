module Packet
  class Client
    def initialize(opts = nil)
      case opts
      when nil
        conf = Packet.configuration
        opts = conf.faraday_options
      when String
        conf = Configuration.new
        conf.auth_token = opts
        opts = conf.faraday_options
      when Hash
        conf = Configuration.new
        opts.each_pair { |k, v| conf.send(":#{k}=", v) }
        opts = conf.faraday_options
      else
        fail InvalidConfiguration
      end

      @conn = Faraday.new(opts) do |faraday|
        faraday.request  :json
        faraday.response :json, content_type: /\bjson$/
        faraday.response Packet::ErrorHandler
        faraday.adapter  Faraday.default_adapter
      end
    end

    #
    # Top-level API methods
    #

    def add_email_address(address, default = false)
      body = {
        'address' => address,
        'default' => default
      }
      post('/emails', body)
    end

    def add_ssh_key(label, key)
      body = {
        'label' => label,
        'key'   => key
      }
      post('/ssh-keys', body)
    end

    def create_project(name)
      body = {
        'name' => name
      }
      post('/projects', body)
    end

    def device(id)
      get("/devices/#{id}")
    end

    def events(params = {})
      get('/events', params)
    end

    def facilities
      get('/facilities')
    end

    def invitation(id)
      get("/invitations/#{id}")
    end

    def membership(id)
      get("/memberships/#{id}")
    end

    def notification(id)
      get("/notifications/#{id}")
    end

    def notifications(params = {})
      get('/notifications', params)
    end

    def operating_systems
      get('/operating-systems')
    end

    def plans
      get('/plans')
    end

    def project(id)
      get("/projects/#{id}")
    end

    def projects
      get('/projects')
    end

    def ssh_keys
      get('/ssh-keys')
    end

    def transfer_request(id)
      get("/transfers/#{id}")
    end

    def user(id)
      get("/users/#{id}")
    end

    #
    # Low-level HTTP methods
    #

    def delete(path)
      @conn.delete do |req|
        req.url(path)
      end
    end

    def get(path, params = nil)
      res = @conn.get do |req|
        req.url(path, params)
      end

      if block_given?
        ret = nil
        res.on_complete { |env| ret = yield env } if block_given?
        ret
      elsif res.success?
        res.body
      else
        res
      end
    end

    def patch(path, body)
      @conn.patch do |req|
        req.url(path)
      end
    end

    def post(path, body)
      @conn.post do |req|
        req.url(path)
        req.body = body
      end
    end
  end
end
