require 'spec_helper'

RSpec.describe Packet::Client::Plans do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end

    stub_request(:get, 'https://api.packet.net/plans')
      .with(headers: { 'Accept' => 'application/json', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type' => 'application/json', 'User-Agent' => 'Faraday v0.9.1', 'X-Auth-Token' => 'auth_token' })
      .to_return(status: 200, body: '{"plans":[{"id":"6d1f1ffa-7912-4b78-b50d-88cc7c8ab40f","slug":"baremetal_1","name":"Type 1","description":"Our Type 1 configuration is a zippy general use server, with an Intel E3-1240 v3 processor and 16GB of RAM.","line":"baremetal","specs":{"cpus":[{"count":1,"type":"Intel E3-1240 v3"}],"memory":{"total":"16GB"},"drives":[{"count":2,"size":"120GB","type":"SSD"}],"nics":[{"count":2,"type":"gigabit"}],"features":{"raid":true,"txt":true}},"pricing":{"hourly":0.4}}]}', headers: { 'Content-Type' => 'application/json; charset=utf-8' })
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
