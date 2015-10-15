require 'spec_helper'

RSpec.describe 'Packet::Plan' do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end

    self.resource_class = Packet::Plan
  end

  describe '.all' do
    it 'returns all plans' do
      test_all :name
    end
  end
end
