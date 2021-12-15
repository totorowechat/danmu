class DanmakuController < ApplicationController
  def download
  end

  def get_video_info
    bvid = params["query"]
    @video_item = VideoItem.find_by url: "https://www.bilibili.com/#{bvid}"

    if @video_item.nil? then
        video_item = VideoItemCreator.new(bvid)
        video_item.get_info
        video_item.get_download_url 0
        video_url = video_item.playurl["dash"]["video"].first["baseUrl"]
        audio_url = video_item.playurl["dash"]["audio"].first["baseUrl"]
        @video_item = VideoItem.new({
                                      :title => video_item.info['title'],
                                      :url => "https://www.bilibili.com/#{bvid}",
                                      :site => "bilibili",
                                      :streams => [video_url, audio_url].to_s,
                                      :extra => {
                                        :video_url => video_url,
                                        :audio_url => audio_url,
                                        :bvid => video_item.bvid,
                                        :aid => video_item.aid
                                      }.to_s,
                                      :pic => video_item.info["pic"]
                                    })
        respond_to do |format|
          if @video_item.save
            format.html { redirect_to @video_item, notice: "Video item was successfully created." }
            format.json { render :show, status: :created, location: @video_item }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @video_item.errors, status: :unprocessable_entity }
          end
        end

    else
      redirect_to @video_item
    end
  end

  def show

  end
  
end
