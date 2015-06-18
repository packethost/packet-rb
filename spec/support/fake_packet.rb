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

  # Ssh Keys
  get '/ssh-keys' do
    json_response 200, 'ssh_keys.json'
  end

  post '/ssh-keys' do
    json_response 200, 'ssh_key.json'
  end

  get '/ssh-keys/:key' do
    json_response 200, 'ssh_key.json'
  end

  patch '/ssh-keys/:key' do
    json_response 200, 'ssh_key.json'
  end

  delete '/ssh-keys/:key' do
    json_response 204
  end

  private

  def json_response(response_code, file_name = nil)
    content_type :json
    status response_code
    File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', file_name), 'rb').read if file_name
  end
end
