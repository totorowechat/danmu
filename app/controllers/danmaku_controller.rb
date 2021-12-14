class DanmakuController < ApplicationController
  def download
  end

  def get_video_info
    video_item = VideoItemCreator.new(params["query"])
    video_item.get_info
    render html: "#{video_item.info}".html_safe
  end
end
