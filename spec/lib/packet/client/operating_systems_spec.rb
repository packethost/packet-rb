require 'spec_helper'

RSpec.describe 'Operating Systems' do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end

    stub_request(:get, 'https://api.packet.net/operating-systems')
      .with(headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'X-Auth-Token' => 'auth_token' })
      .to_return(status: 200, body: '{"operating_systems":[{"slug":"centos_7","name":"CentOS 7","distro":"centos","version":"7"},{"slug":"centos_6","name":"CentOS 6","distro":"centos","version":"6"},{"slug":"coreos_stable","name":"CoreOS (stable)","distro":"coreos","version":"stable"},{"slug":"coreos_beta","name":"CoreOS (beta)","distro":"coreos","version":"beta"},{"slug":"debian_7","name":"Debian 7","distro":"debian","version":"7"},{"slug":"debian_6","name":"Debian 6","distro":"debian","version":"6"},{"slug":"installer","name":"Installer","distro":"installer","version":"installer"},{"slug":"ubuntu_14_04","name":"Ubuntu 14.04 LTS","distro":"ubuntu","version":"14.04"},{"slug":"ubuntu_12_04","name":"Ubuntu 12.04","distro":"ubuntu","version":"12.04"}]}', headers: { 'Content-Type' => 'application/json; charset=utf-8' })
  end

  describe '.operating_systems', :vcr do
    it 'returns all os' do
      operating_systems = Packet.operating_systems
      assert_requested :get, 'https://api.packet.net/operating-systems'
    end
  end
end
