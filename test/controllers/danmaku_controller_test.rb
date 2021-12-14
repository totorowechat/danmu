require "test_helper"

class DanmakuControllerTest < ActionDispatch::IntegrationTest
  test "should get download" do
    get root_path
    assert_response :success
    assert_select "title", "Home | Danmaku"
  end

  test "should get get_video_info" do
    post danmaku_get_video_info_path
    assert_response :success
  end
end
