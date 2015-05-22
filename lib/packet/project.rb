require 'packet/entity'
require 'packet/ssh_key'

module Packet
  class Project < Entity
    attr_accessor :id, :name, :ssh_keys

    def initialize(attributes = {})
      super
      self.ssh_keys = ssh_keys.map { |data| SshKey.new(data) } if ssh_keys
    end
  end
end
