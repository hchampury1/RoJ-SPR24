require 'test_helper'

class WebinarsaboutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get webinarsabout_index_url
    assert_response :success
  end

end
