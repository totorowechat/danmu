require "test_helper"

class DanmakuControllerTest < ActionDispatch::IntegrationTest
  test "should get download" do
    get root_path
    assert_response :success
    assert_select "title", "Home | Danmaku"
  end
end
