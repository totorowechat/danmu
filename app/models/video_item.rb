# frozen_string_literal: true

class VideoItem < ApplicationRecord
  has_many :search_history, dependent: :destroy
end
