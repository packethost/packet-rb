require 'packet/client'
require 'packet/configuration'
require 'packet/device'
require 'packet/entity'
require 'packet/errors'
require 'packet/facility'
require 'packet/plan'
require 'packet/project'
require 'packet/ssh_key'
require 'packet/version'

module Packet
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset
    @configuration = Configuration.new
  end
end
