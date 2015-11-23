$LOAD_PATH.unshift File.dirname(__FILE__)

require 'faraday'
require 'faraday_middleware'
require 'packet/error_handler'
# require 'packet/parser'
require 'packet/configuration'
require 'packet/client'
require 'packet/version'

module Packet
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
    true
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.client
    @client ||= Client.new
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

  autoload :Entity, 'packet/entity'
  autoload :Mutable, 'packet/mutable'
  autoload :Device, 'packet/device'
  autoload :EmailAddress, 'packet/email_address'
  autoload :Facility, 'packet/facility'
  autoload :Invitation, 'packet/invitation'
  autoload :Notification, 'packet/notification'
  autoload :OperatingSystem, 'packet/operating_system'
  autoload :Plan, 'packet/plan'
  autoload :Project, 'packet/project'
  autoload :SSHKey, 'packet/ssh_key'
  autoload :TransferRequest, 'packet/transfer_request'
  autoload :User, 'packet/user'
end
