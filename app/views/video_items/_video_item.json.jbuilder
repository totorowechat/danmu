json.extract! video_item, :id, :title, :url, :site, :streams, :extra, :created_at, :updated_at
json.url video_item_url(video_item, format: :json)
