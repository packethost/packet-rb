module Packet
  class Project < Entity
    has_many :ssh_keys
    has_many :devices
  end
end
