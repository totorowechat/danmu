require "test_helper"

class VideoItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_item = video_items(:one)
  end

  test "should get index" do
    get video_items_url
    assert_response :success
  end

  test "should get new" do
    get new_video_item_url
    assert_response :success
  end

  test "should create video_item" do
    assert_difference('VideoItem.count') do
      post video_items_url, params: { video_item: { extra: @video_item.extra, site: @video_item.site, streams: @video_item.streams, title: @video_item.title, url: @video_item.url } }
    end

    assert_redirected_to video_item_url(VideoItem.last)
  end

  test "should show video_item" do
    get video_item_url(@video_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_video_item_url(@video_item)
    assert_response :success
  end

  test "should update video_item" do
    patch video_item_url(@video_item), params: { video_item: { extra: @video_item.extra, site: @video_item.site, streams: @video_item.streams, title: @video_item.title, url: @video_item.url } }
    assert_redirected_to video_item_url(@video_item)
  end

  test "should destroy video_item" do
    assert_difference('VideoItem.count', -1) do
      delete video_item_url(@video_item)
    end

    assert_redirected_to video_items_url
  end
end
