require 'sinatra/base'

class FakePacket < Sinatra::Base
  # Operating Systems
  get '/operating-systems' do
    json_response 200, 'operating_systems.json'
  end

  # Plans
  get '/plans' do
    json_response 200, 'plans.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', file_name), 'rb').read
  end
end
