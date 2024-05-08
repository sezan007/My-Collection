require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get admin" do
    get admins_admin_url
    assert_response :success
  end
end
