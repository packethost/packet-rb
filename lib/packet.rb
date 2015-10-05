$LOAD_PATH.unshift File.dirname(__FILE__)

require 'her'
require 'packet/configuration'
require 'packet/parser'
require 'packet/errors'
require 'packet/version'

module Packet
  class << self
    def configure
      yield(configuration)
      configuration.setup if configuration.valid?
      true
    end

    private

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
