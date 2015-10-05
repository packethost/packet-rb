require 'spec_helper'

RSpec.describe 'Packet::SshKey' do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end

    self.resource_class = Packet::SshKey
  end

  describe '.all' do
    it 'returns all ssh keys' do
      test_all :label
    end
  end

  describe '.ssh_key' do
    it 'returns an ssh key' do
      test_find :label
    end
  end

  describe '.create_ssh_key' do
    it 'create an shh_key and return it' do
      test_create :label, 'ssh_key'
    end
  end

  describe '.update_ssh_key' do
    it 'updates and returns an ssh key' do
      test_update :label, 'ssh_key'
    end
  end

  describe '.delete_ssh_key' do
    it 'deletes an ssh key' do
      test_delete
    end
  end
end
