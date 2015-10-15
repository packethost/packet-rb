require 'spec_helper'

RSpec.describe 'Packet::OperatingSystem' do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end

    self.resource_class = Packet::OperatingSystem
  end

  describe '.all' do
    it 'returns all operating systems' do
      test_all :name
    end
  end
end
