require 'test_helper'

class ToppagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get toppages_index_url
    assert_response :success
  end

  test "should get about" do
    get toppages_about_url
    assert_response :success
  end

  test "should get contact" do
    get toppages_contact_url
    assert_response :success
  end

end
