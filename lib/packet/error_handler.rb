module Packet
  class ErrorHandler < Faraday::Response::Middleware
    def on_complete(env)
      @env = env
      fail StandardError, error_description if error?
    end

    private

    def error?
      @env[:body][:data].key?(:error)
    end

    def error_description
      @env[:body][:data][:error]
    end
  end
end
