require 'test_helper'

class WebinarjoinControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get webinarjoin_index_url
    assert_response :success
  end

end
