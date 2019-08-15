require 'test_helper'

class GolfclubsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get golfclubs_create_url
    assert_response :success
  end

  test "should get destroy" do
    get golfclubs_destroy_url
    assert_response :success
  end

end
