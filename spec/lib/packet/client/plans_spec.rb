require 'spec_helper'

RSpec.describe 'Plans' do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end
  end

  describe '.plans', :vcr do
    it 'returns all plans' do
      plans = Packet.plans
      assert_requested :get, 'https://api.packet.net/plans'
    end
  end
end
