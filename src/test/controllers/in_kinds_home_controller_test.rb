require 'test_helper'

class inkindsHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get in_kinds_home_index_url
    assert_response :success
  end

end
