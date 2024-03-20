class Image < ApplicationRecord
  has_many :layer_on_cards, as: :layer
end
