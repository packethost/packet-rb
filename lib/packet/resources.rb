require 'active_support/core_ext/string'

module Packet
  class Client
    module Resources
      RESOURCES = [{ name: 'user', methods: [:get, :update] },
                   { name: 'projects', methods: [:all, :get, :update, :create, :delete] },
                   { name: 'devices', methods: [:all, :get, :update, :create, :delete] },
                   { name: 'operating_systems', methods: [:all] },
                   { name: 'plans', methods: [:all] },
                   { name: 'ssh_keys', methods: [:all, :get, :update, :create, :delete] }]

      def self.build_method_name(resource, method)
        case method
        when :get then "get_#{resource[:name].singularize}"
        when :update then "update_#{resource[:name].singularize}"
        when :all then resource[:name]
        when :create then "create_#{resource[:name].singularize}"
        when :delete then "delete_#{resource[:name].singularize}"
        end
      end

      RESOURCES.each do |resource|
        resource[:methods].each do |method|
          method_name = build_method_name resource, method
          slug = (resource.key?(:slug) ? resource[:slug] : resource[:name]).dasherize

          case method
          when :get, :all
            define_method(method_name) do |*args|
              get(slug, *args)
            end
          when :create
            define_method(method_name) do |*args|
              post(slug, *args)
            end
          when :update
            define_method(method_name) do |id, *args|
              post("#{slug}/#{id}", *args)
            end
          when :delete
            define_method(method_name) do |id, *args|
              delete("#{slug}/#{id}", *args)
            end
          end
        end
      end
    end
  end
end
