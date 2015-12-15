$LOAD_PATH.unshift File.dirname(__FILE__)

require 'packet/client'
require 'packet/configuration'
require 'packet/entity'
require 'packet/errors'
require 'packet/project'
require 'packet/version'

module Packet
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
    reset_client!
    true
  end

  def self.reset!
    @configuration = Configuration.new
    reset_client!
  end

  def self.client
    @client ||= Packet::Client.new
  end

  private

  def self.reset_client!
    @client = nil
  end

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
