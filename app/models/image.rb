class Image < ApplicationRecord
  has_many :layer_on_cards, as: :layer
  mount_uploader :url, ImageUrlUploader
end
