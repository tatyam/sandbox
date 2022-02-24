class City < ApplicationRecord
  scope :active, -> { where(deleted: false) }
end
