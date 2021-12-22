# frozen_string_literal: true

require 'net/http'
require 'json'

class VideoItemCreator
  attr_reader :bvid, :aid, :info, :playurl

  def initialize(bvid)
    @bvid = bvid
    @aid = bvid2aid bvid
  end

  def bvid2aid(bvid)
    table = 'fZodR9XQDSUm21yCkr6zBqiveYah8bt4xsWpHnJE7jL5VG3guMTKNPAwcF'
    tr = {}
    (0..57).each do |i|
      tr[table[i]] = i
    end
    s = [11, 10, 3, 8, 4, 6]
    xor = 177_451_812
    add = 8_728_348_608

    def dec(x, tr, s, add, xor)
      r = 0
      (0..5).each do |i|
        r += tr[x[s[i]]] * 58**i
      end
      (r - add) ^ xor
    end
    dec bvid, tr, s, add, xor
  end

  def get_info
    params = {
      bvid: @bvid,
      aid: @aid
    }

    uri = URI.parse('https://api.bilibili.com/x/web-interface/view')
    uri.query = URI.encode_www_form(params)
    begin
      res = Net::HTTP.get_response(uri)
      json = JSON.parse(res.body)
      @info = json['data']
      @info
    rescue StandardError
      false
    end
  end

  def get_page_id_by_index(page_index)
    pages = @info['pages']
    page = pages[page_index]
    page['cid']
  end

  def get_download_url(page_index = nil, cid = nil)
    cid = get_page_id_by_index page_index if cid.nil?

    uri = URI.parse('https://api.bilibili.com/x/player/playurl')

    params = {
      avid: @aid,
      cid: cid,
      qn: 120,
      otype: 'json',
      fnval: 16,
      fourk: 1
    }

    uri.query = URI.encode_www_form params

    begin
      res = Net::HTTP.get_response(uri)
      json = JSON.parse(res.body)
      @playurl = json['data']
      @playurl
    rescue StandardError
      'get_download_url: network error'
    end
  end
end
