require 'spec_helper'

RSpec.describe Packet::Client::SshKeys do
  before do
    Packet.configure do |config|
      config.auth_token = 'auth_token'
    end
  end

  describe '.ssh_keys', :vcr do
    it 'returns all ssh keys' do
      ssh_keys = Packet.ssh_keys
      expect(ssh_keys).to be_kind_of Array
      expect(ssh_keys.first.label).not_to be_nil
      assert_requested :get, 'https://api.packet.net/ssh-keys'
    end
  end

  describe '.ssh_key', :vcr do
    it 'returns an ssh key' do
      ssh_key_id = SecureRandom.uuid
      ssh_key = Packet.ssh_key(ssh_key_id)
      expect(ssh_key).to be_kind_of Packet::SshKey
      expect(ssh_key.label).not_to be_nil
      assert_requested :get, "https://api.packet.net/ssh-keys/#{ssh_key_id}"
    end
  end

  describe '.create_ssh_key' do
    it 'create an shh_key and return it' do
      ssh_key = Packet.create_ssh_key('key_label', 'ssh_key')
      expect(ssh_key).to be_kind_of Packet::SshKey
      expect(ssh_key.label).not_to be_nil
      assert_requested :post, 'https://api.packet.net/ssh-keys'
    end
  end

  describe '.update_ssh_key', :vcr do
    it 'updates and returns an ssh key' do
      ssh_key_id = SecureRandom.uuid
      ssh_key = Packet.update_ssh_key(ssh_key_id, label: 'key_label')
      expect(ssh_key).to be_kind_of Packet::SshKey
      expect(ssh_key.label).not_to be_nil
      assert_requested :patch, "https://api.packet.net/ssh-keys/#{ssh_key_id}"
    end
  end

  describe '.delete_ssh_key', :vcr do
    it 'deletes an ssh key' do
      ssh_key_id = SecureRandom.uuid
      result = Packet.delete_ssh_key(ssh_key_id)
      expect(result).to be(true)
      assert_requested :delete, "https://api.packet.net/ssh-keys/#{ssh_key_id}"
    end
  end
end
