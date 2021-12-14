class DanmakuController < ApplicationController
  def download
  end

  def get_video_info
    json = VideoItemCreator.new(params["query"]).get_info
    render html: "#{json}".html_safe
  end
end
