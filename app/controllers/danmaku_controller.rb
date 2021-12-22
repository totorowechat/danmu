# frozen_string_literal: true

require 'json'
require 'uri'

class DanmakuController < ApplicationController
  before_action :set_video_item, only: %i[play_on_mpv]

  def download; end

  def get_video_info
    bvid = if valid_url? params['query']
             params['query'].split('/')
           else
             params['query']
           end

    bvid = /BV[0-9a-zA-Z]+/.match(params['query']).to_s

    if bvid.empty?
      respond_to do |format|
        format.html { render html: 'bvid not valid', status: :unprocessable_entity }
        format.json { render json: @video_item.errors, status: :unprocessable_entity }
      end
    else

      @video_item = VideoItem.find_by url: "https://www.bilibili.com/#{bvid}"

      if @video_item.nil?
        create_video_item(bvid)
        respond_to do |format|
          if @video_item.save
            format.html { redirect_to @video_item, notice: 'Video item was successfully created.' }
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
  end

  def play_on_mpv
    update_video_streams_and_extra
    @video_url = JSON.parse(@video_item.streams).first
    @audio_url = JSON.parse(@video_item.streams).second
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_video_item
    @video_item = VideoItem.find(params[:id])
  end

  def create_video_item(bvid)
    video_item_c = VideoItemCreator.new(bvid)
    video_item_c.get_info
    video_item_c.get_download_url 0
    video_url = video_item_c.playurl['dash']['video'].first['baseUrl']
    audio_url = video_item_c.playurl['dash']['audio'].first['baseUrl']
    @video_item = VideoItem.new({
                                  title: video_item_c.info['title'],
                                  url: "https://www.bilibili.com/#{bvid}",
                                  site: 'bilibili',
                                  streams: [video_url, audio_url].to_s,
                                  extra: {
                                    video_url: video_url,
                                    audio_url: audio_url,
                                    bvid: video_item_c.bvid,
                                    aid: video_item_c.aid
                                  }.to_s,
                                  pic: video_item_c.info['pic']
                                })
    video_item_c
  end

  def update_video_streams_and_extra
    old_video_item = VideoItem.find(@video_item.id)
    bvid = @video_item.url.split('/').last
    video_item_c = create_video_item bvid
    @video_url = JSON.parse(@video_item.streams).first
    @audio_url = JSON.parse(@video_item.streams).second
    old_video_item.update(streams: [@video_url, @audio_url].to_s,
                          extra: {
                            video_url: @video_url,
                            audio_url: @audio_url,
                            bvid: bvid,
                            aid: video_item_c.aid
                          }.to_s)
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
