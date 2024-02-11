require 'test_helper'

class WebinarsUnenrollControllerTest < ActionDispatch::IntegrationTest
  test "should get deregister" do
    get webinars_unenroll_deregister_url
    assert_response :success
  end

end
