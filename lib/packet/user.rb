require 'packet/entity'

module Packet
  class User < Entity
    attr_accessor :first_name, :last_name, :full_name, :email, :two_factor_auth, :avatar_url, :max_projects
  end
end
