require 'test_helper'

class DonationsControllerTest < ActionDispatch::IntegrationTest
  test "should get donations" do
    get donations_donations_url
    assert_response :success
  end

end
