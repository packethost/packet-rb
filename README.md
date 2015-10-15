Packet
======

A Ruby client for the Packet API.

<a href="https://rubygems.org/gems/packethost"><img src="http://img.shields.io/gem/v/packet.svg" /></a>
<a href="https://app.shippable.com/projects/552552825ab6cc1352bc6ff9"><img src="https://img.shields.io/shippable/552552825ab6cc1352bc6ff9.svg" /></a>


Configuration
-------------

You can either configure the library in a global way (easier):

    Packet.configure do |config|
      config.auth_token = 'my_api_token'
    end


Usage
-----

Using the Packet API is as easy as using ActiveRecord. For instance to ask for a list of plans, you can just do

```
Packet::Plan.all.each { |plan| puts plan.name }
```

Or want to list the devices you have in your projects? Easy...

```
Packet::Project.all.each do |project|
  project.devices.each { |d| puts d.hostname }
end
```

If you want to find a device using its id, you can use `find`

```
my_device = Packet::Device.find('fa3aa4f0-4a1a-4a68-8fad-90ff777de427')

```

GlobalID
--------

This library comes with a `GlobalID::Locator` implementation that you can use
to load an object from the Packet API remotely. To set it up, do something like
this in your initializer:

    require 'packet/global_id'

    GlobalID::Locator.use 'packet-api', Packet::GlobalIDLocator.new

Once you get that up, you should be able to load entities from the Packet API
like so:

    project_gid = 'gid://packet-api/Packet::Project/bf821113-c71e-41f0-99a0-9c2943ea1878'
    GlobalID::Locator.locate project_gid
    => #<Packet:Project:0x007fae94bf6298 @id="bf821113-c71e-41f0-99a0-9c2943ea1878">

Contributing
------------

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so we don't break it in a future version unintentionally. You can run the test suite with `bundle exec ci`.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so we can cherry-pick around it.

Copyright
---------

Copyright (c) 2015 Packet Host. See `LICENSE` for further details.
