require "application_system_test_case"

class CallsTest < ApplicationSystemTestCase
  setup do
    @call = calls(:one)
  end

  test "visiting the index" do
    visit calls_url
    assert_selector "h1", text: "Calls"
  end

  test "creating a Call" do
    visit calls_url
    click_on "New Call"

    fill_in "Caller type", with: @call.caller_type
    fill_in "Date", with: @call.date
    fill_in "Inmate num", with: @call.inmate_num
    fill_in "Institution", with: @call.institution
    fill_in "Location", with: @call.location
    fill_in "Name", with: @call.name
    fill_in "Notes", with: @call.notes
    fill_in "Phone number", with: @call.phone_number
    fill_in "Point of contact", with: @call.point_of_contact
    click_on "Create Call"

    assert_text "Call was successfully created"
    click_on "Back"
  end

  test "updating a Call" do
    visit calls_url
    click_on "Edit", match: :first

    fill_in "Caller type", with: @call.caller_type
    fill_in "Date", with: @call.date
    fill_in "Inmate num", with: @call.inmate_num
    fill_in "Institution", with: @call.institution
    fill_in "Location", with: @call.location
    fill_in "Name", with: @call.name
    fill_in "Notes", with: @call.notes
    fill_in "Phone number", with: @call.phone_number
    fill_in "Point of contact", with: @call.point_of_contact
    click_on "Update Call"

    assert_text "Call was successfully updated"
    click_on "Back"
  end

  test "destroying a Call" do
    visit calls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Call was successfully destroyed"
  end
end
