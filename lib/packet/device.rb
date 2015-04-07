require 'packet/entity'
require 'packet/facility'
require 'packet/plan'
require 'packet/project'

module Packet
  class Device < Entity
    attr_accessor :id, :name, :hostname, :ip_addresses, :project, :facility,
                  :plan, :userdata

    def initialize(attributes = {})
      super
      self.project = Project.new(project) if project
      self.facility = Facility.new(facility) if facility
      self.plan = Plan.new(plan) if plan
    end

    def ip_addresses
      @ip_addresses || []
    end
  end
end
