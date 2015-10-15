module Helper
  attr_accessor :resource_class

  def test_find(prop)
    id = SecureRandom.uuid
    entity = resource_class.send(:find, id)
    expect(entity).to be_kind_of resource_class
    expect(entity.send(prop)).not_to be_nil
    assert_requested :get, "#{resource_url}/#{id}"
  end

  def test_all(prop)
    entities = resource_class.send(:all)
    expect(entities).to be_kind_of Array
    expect(entities.first.send(prop)).not_to be_nil
    assert_requested :get, resource_url
  end

  def test_create(prop, value)
    entity = resource_class.create(prop => value)
    expect(entity).to be_kind_of resource_class
    expect(entity.send(prop)).not_to be_nil
    assert_requested :post, resource_url
  end

  def test_update(prop, value)
    id = SecureRandom.uuid
    entity = resource_class.save_existing(id, prop => value)
    expect(entity).to be_kind_of resource_class
    expect(entity.send(prop)).not_to be_nil
    assert_requested :put, "#{resource_url}/#{id}"
  end

  def test_delete
    id = SecureRandom.uuid
    resource_class.destroy_existing(id)
    assert_requested :delete, "#{resource_url}/#{id}"
  end

  def resource_url
    "#{Packet::Configuration::API_URL}/#{resource_name}"
  end

  def resource_name
    resource_class.to_s.demodulize.pluralize.underscore.dasherize
  end
end
