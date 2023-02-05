require "application_system_test_case"

class JoinsTest < ApplicationSystemTestCase
  setup do
    @join = joins(:one)
  end

  test "visiting the index" do
    visit joins_url
    assert_selector "h1", text: "Joins"
  end

  test "creating a Join" do
    visit joins_url
    click_on "New Join"

    fill_in "Mail", with: @join.mail_id
    fill_in "Tag", with: @join.tag_id
    click_on "Create Join"

    assert_text "Join was successfully created"
    click_on "Back"
  end

  test "updating a Join" do
    visit joins_url
    click_on "Edit", match: :first

    fill_in "Mail", with: @join.mail_id
    fill_in "Tag", with: @join.tag_id
    click_on "Update Join"

    assert_text "Join was successfully updated"
    click_on "Back"
  end

  test "destroying a Join" do
    visit joins_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Join was successfully deleted."
  end
end
