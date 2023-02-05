require "application_system_test_case"

class EventDetailsTest < ApplicationSystemTestCase
  setup do
    @event_detail = event_details(:one)
  end

  test "visiting the index" do
    visit event_details_url
    assert_selector "h1", text: "Event Details"
  end

  test "creating a Event detail" do
    visit event_details_url
    click_on "New Event Detail"

    fill_in "Description", with: @event_detail.description
    fill_in "Eventdatetime", with: @event_detail.eventdatetime
    fill_in "Speakers", with: @event_detail.speakers
    fill_in "Title", with: @event_detail.title
    click_on "Create Event detail"

    assert_text "Event detail was successfully created"
    click_on "Back"
  end

  test "updating a Event detail" do
    visit event_details_url
    click_on "Edit", match: :first

    fill_in "Description", with: @event_detail.description
    fill_in "Eventdatetime", with: @event_detail.eventdatetime
    fill_in "Speakers", with: @event_detail.speakers
    fill_in "Title", with: @event_detail.title
    click_on "Update Event detail"

    assert_text "Event detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Event detail" do
    visit event_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event detail was successfully destroyed"
  end
end
