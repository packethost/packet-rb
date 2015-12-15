require 'sinatra/base'

class FakePacket < Sinatra::Base
  get('/operating-systems') { json_response 200, 'operating_systems.json' }
  get('/plans') { json_response 200, 'plans.json' }
  get('/ssh-keys') { json_response 200, 'ssh_keys.json' }
  post('/ssh-keys') { json_response 201, 'ssh_key.json' }
  get('/ssh-keys/:key') { json_response 200, 'ssh_key.json' }
  patch('/ssh-keys/:key') { json_response 200, 'ssh_key.json' }
  delete('/ssh-keys/:key') { json_response 204 }

  private

  def json_response(response_code, file_name = nil)
    content_type :json
    status response_code
    File.open(File.join(File.dirname(__FILE__), '..', 'fixtures', file_name), 'rb').read if file_name
  end
end
