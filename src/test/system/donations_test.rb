require "application_system_test_case"

class inkindTest < ApplicationSystemTestCase
  setup do
    @donation = inkind(:one)
  end

  test "visiting the index" do
    visit inkind_url
    assert_selector "h1", text: "inkind"
  end

  test "creating a Inkind" do
    visit inkind_url
    click_on "New Donation"

    fill_in "Date", with: @inkind.date
    fill_in "Description", with: @inkind.description
    fill_in "Name", with: @inkind.name
    fill_in "Type", with: @inkind.genre
    fill_in "User", with: @inkind.user
    fill_in "Value", with: @inkind.value
    click_on "Create Donation"

    assert_text "Donation was successfully created"
    click_on "Back"
  end

  test "updating a Inkind" do
    visit inkind_url
    click_on "Edit", match: :first

    fill_in "Date", with: @inkind.date
    fill_in "Description", with: @inkind.description
    fill_in "Name", with: @inkind.name
    fill_in "Type", with: @inkind.genre
    fill_in "User", with: @inkind.user
    fill_in "Value", with: @inkind.value
    click_on "Update inkind"

    assert_text "Donation was successfully updated"
    click_on "Back"
  end

  test "destroying a Inkind" do
    visit inkind_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Donation was successfully destroyed"
  end
end
