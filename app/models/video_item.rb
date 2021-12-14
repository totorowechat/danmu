class VideoItem < ApplicationRecord
  has_many :search_history, dependent: :destroy
end
