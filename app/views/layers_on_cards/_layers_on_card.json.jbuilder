json.extract! layers_on_card, :id, :name, :card_id, :layer_id, :layer_type, :status, :order, :user_id, :created_at, :updated_at
json.url layers_on_card_url(layers_on_card, format: :json)
