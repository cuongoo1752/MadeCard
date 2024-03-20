json.extract! event, :id, :content, :status, :user_id, :order, :created_at, :updated_at
json.url event_url(event, format: :json)
