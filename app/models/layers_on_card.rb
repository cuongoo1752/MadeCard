class LayersOnCard < ApplicationRecord
  belongs_to :card
  belongs_to :user
  belongs_to :layer, polymorphic: true
end
