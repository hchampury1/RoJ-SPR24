require "application_system_test_case"

class ResponsesTest < ApplicationSystemTestCase
  setup do
    @response = responses(:one)
  end

  test "visiting the index" do
    visit responses_url
    assert_selector "h1", text: "Responses"
  end

  test "creating a Response" do
    visit responses_url
    click_on "New Response"

    fill_in "Date sent", with: @response.date_sent
    fill_in "Response message", with: @response.response_message
    check "Response sent" if @response.response_sent
    click_on "Create Response"

    assert_text "Response was successfully created"
    click_on "Back"
  end

  test "updating a Response" do
    visit responses_url
    click_on "Edit", match: :first

    fill_in "Date sent", with: @response.date_sent
    fill_in "Response message", with: @response.response_message
    check "Response sent" if @response.response_sent
    click_on "Update Response"

    assert_text "Response was successfully updated"
    click_on "Back"
  end

  test "destroying a Response" do
    visit responses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Response was successfully deleted."
  end
end
