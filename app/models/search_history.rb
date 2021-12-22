# frozen_string_literal: true

class SearchHistory < ApplicationRecord
  belongs_to :video_item
end
