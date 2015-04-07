Packet
======

A Ruby client for the Packet API.

Configuration
-------------

You can either configure the library in a global way (easier):

    Packet.configure do |config|
      config.api_token = 'my_api_token'
    end

or create and use an individual instance of `Packet::Client` (more complex):

    Packet::Client.new(url, api_token)

Generally speaking, you'll probably want to configure it globally if you only
ever use a single API token.

Usage
-----

If you configured the library globally, you can just call methods on the
`Packet` module. For example:

    Packet.devices
    => [#<Packet::Device>, #<Packet::Device>]

If you configured a `Packet::Client` manually, you can call those same methods
on the client itself:

    client = Packet::Client.new( ... )
    client.devices
    => [#<Packet::Device>, #<Packet::Device>]

See a [list of available methods](https://github.com/packethost/packet-rb/tree/master/lib/packet/client).

GlobalID
--------

This library comes with a `GlobalID::Locator` implementation that you can use
to load object from the Packet API remotely. To set it up, do something like
this in your initializer:

    require 'packet/global_id'

    GlobalID::Locator.use :packet_api, Packet::GlobalIDLocator.new

    # Optionally include an instance of `Packet::Client` to use for fetching:
    client = Packet::Client.new(url, api_token)
    GlobalID::Locator.use :packet_api, Packet::GlobalIDLocator.new(client)

Once you get that up, you should be able to load entities from the Packet API
like so:

    project_gid = 'gid://packet-api/Project/bf821113-c71e-41f0-99a0-9c2943ea1878'
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
