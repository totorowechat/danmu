# frozen_string_literal: true

json.array! @video_items, partial: 'video_items/video_item', as: :video_item
