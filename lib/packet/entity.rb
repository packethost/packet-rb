module Packet
  class Entity
    include Her::Model
    parse_root_in_json true, format: :active_model_serializers
  end
end
