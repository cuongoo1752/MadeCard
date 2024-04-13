class FixFont < ApplicationRecord
  belongs_to :user
  mount_uploader :font, FontUploader
end
