require 'webmock/rspec'

RSpec.configure do |config|
  config.before { WebMock.disable_net_connect!(allow_localhost: true) }
end
