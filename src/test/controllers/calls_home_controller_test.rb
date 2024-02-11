require 'test_helper'

class CallsHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calls_home_index_url
    assert_response :success
  end

end
