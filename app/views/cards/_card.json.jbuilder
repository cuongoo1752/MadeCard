json.extract! card, :id, :is_public, :status, :user_id, :order, :created_at, :updated_at
json.url card_url(card, format: :json)
