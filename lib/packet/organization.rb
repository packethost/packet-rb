module Packet
  class Organization
    include Entity

    attr_accessor :name
    attr_accessor :description
    attr_accessor :website
    attr_accessor :twitter
    attr_accessor :tax_id
    attr_accessor :main_phone
    attr_accessor :billing_phone
    attr_accessor :credit_amount
    attr_accessor :personal
    attr_accessor :customdata
    attr_accessor :attn
    attr_accessor :purchase_order
    attr_accessor :billing_name
    attr_accessor :short_id
    attr_accessor :account_id
    attr_accessor :default_payment_method
    attr_accessor :logo_url
    attr_accessor :enabled_features
    attr_accessor :maintenance_email
    attr_accessor :abuse_email

    serializer_key :id
  end
end
