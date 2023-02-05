require "application_system_test_case"

class DonarsTest < ApplicationSystemTestCase
  setup do
    @donar = donars(:one)
  end

  test "visiting the index" do
    visit donars_url
    assert_selector "h1", text: "Donars"
  end

  test "creating a Donar" do
    visit donars_url
    click_on "New Donar"

    fill_in "Email", with: @donar.email
    fill_in "Location", with: @donar.location
    fill_in "Name", with: @donar.name
    fill_in "Phonenumber", with: @donar.phoneNumber
    click_on "Create Donar"

    assert_text "Donar was successfully created"
    click_on "Back"
  end

  test "updating a Donar" do
    visit donars_url
    click_on "Edit", match: :first

    fill_in "Email", with: @donar.email
    fill_in "Location", with: @donar.location
    fill_in "Name", with: @donar.name
    fill_in "Phonenumber", with: @donar.phoneNumber
    click_on "Update Donar"

    assert_text "Donar was successfully updated"
    click_on "Back"
  end

  test "destroying a Donar" do
    visit donars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Donar was successfully destroyed"
  end
end
