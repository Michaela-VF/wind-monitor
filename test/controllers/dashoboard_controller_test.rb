require "test_helper"

class DashoboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashoboard_index_url
    assert_response :success
  end
end
