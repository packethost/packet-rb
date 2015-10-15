require 'spec_helper'

module Packet
  RSpec.describe Configuration do
    describe '.setup' do
      it { expect { Configuration.new.setup }.to raise_error(Configuration::InvalidConfiguration) }
    end
  end
end
