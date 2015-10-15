require 'spec_helper'

RSpec.describe Packet do
  describe '.configure' do
    it { expect { |conf| Packet.configure(&conf) }.to yield_with_args(Packet::Configuration) }
  end
end
