$LOAD_PATH.unshift File.dirname(__FILE__)

require 'her'
require 'packet/error_handler'
require 'packet/parser'
require 'packet/configuration'
require 'packet/client'
require 'packet/version'

module Packet
  class << self
    def configure
      yield(configuration)
      configuration.setup
    end

    private

    def configuration
      @configuration ||= Configuration.new
    end
  end

  autoload :Entity, 'packet/entity'
  autoload :Device, 'packet/device'
  autoload :Facility, 'packet/facility'
  autoload :OperatingSystem, 'packet/operating_system'
  autoload :Plan, 'packet/plan'
  autoload :Project, 'packet/project'
  autoload :SshKey, 'packet/ssh_key'
  autoload :User, 'packet/user'
end
