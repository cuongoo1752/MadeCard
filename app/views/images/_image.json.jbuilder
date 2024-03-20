json.extract! image, :id, :name, :url, :status, :created_at, :updated_at
json.url image_url(image, format: :json)
