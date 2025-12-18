require "test_helper"

class SignUpsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sign_ups_show_url
    assert_response :success
  end
end
