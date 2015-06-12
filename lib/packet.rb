$LOAD_PATH.unshift File.dirname(__FILE__)

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
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
    true
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.client
    Packet::Client.instance
  end

  private

  def self.respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name, include_private)
  end if RUBY_VERSION >= '1.9'

  def self.respond_to?(method_name, include_private = false)
    client.respond_to?(method_name, include_private) || super
  end if RUBY_VERSION < '1.9'

  def self.method_missing(method_name, *args, &block)
    if client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    else
      super
    end
  end
end
