require 'spec_helper'

RSpec.describe Packet::Client::Plans do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end
  end

  describe '.plans', :vcr do
    it 'returns all plans' do
      plans = Packet.plans
      expect(plans).to be_kind_of Array
      expect(plans.first.name).not_to be_nil
      assert_requested :get, 'https://api.packet.net/plans'
    end
  end
end
