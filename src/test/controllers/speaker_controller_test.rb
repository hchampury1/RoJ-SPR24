require 'test_helper'

class SpeakerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get speaker_show_url
    assert_response :success
  end

end
