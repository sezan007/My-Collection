require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get users" do
    get pages_users_url
    assert_response :success
  end

  test "should get admins" do
    get pages_admins_url
    assert_response :success
  end
end
