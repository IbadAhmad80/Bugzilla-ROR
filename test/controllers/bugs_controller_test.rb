require "test_helper"

class BugsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bugs_new_url
    assert_response :success
  end

  test "should get create" do
    get bugs_create_url
    assert_response :success
  end

  test "should get show" do
    get bugs_show_url
    assert_response :success
  end
end
