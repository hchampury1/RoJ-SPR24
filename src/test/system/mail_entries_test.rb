require "application_system_test_case"

class MailEntriesTest < ApplicationSystemTestCase
  setup do
    @mail_entry = mail_entries(:one)
  end

  test "visiting the index" do
    visit mail_entries_url
    assert_selector "h1", text: "Mail Entries"
  end

  test "creating a Mail entry" do
    visit mail_entries_url
    click_on "New Mail Entry"

    fill_in "Case status", with: @mail_entry.case_status
    fill_in "Crime age", with: @mail_entry.crime_age
    fill_in "Current age", with: @mail_entry.current_age
    fill_in "Date", with: @mail_entry.date
    fill_in "Inmate", with: @mail_entry.inmate_id
    fill_in "Label", with: @mail_entry.label
    fill_in "Offender race", with: @mail_entry.offender_race
    fill_in "Sender name", with: @mail_entry.sender_name
    fill_in "Victim race", with: @mail_entry.victim_race
    fill_in "Inquiry Type", with: @mail_entry.inquiryType
    fill_in "PDF", with: @mail_entry.pdf
    click_on "Create Mail entry"

    assert_text "Mail entry was successfully created"
    click_on "Back"
  end

  test "updating a Mail entry" do
    visit mail_entries_url
    click_on "Edit", match: :first

    fill_in "Case status", with: @mail_entry.case_status
    fill_in "Crime age", with: @mail_entry.crime_age
    fill_in "Current age", with: @mail_entry.current_age
    fill_in "Date", with: @mail_entry.date
    fill_in "Inmate", with: @mail_entry.inmate_id
    fill_in "Label", with: @mail_entry.label
    fill_in "Offender race", with: @mail_entry.offender_race
    fill_in "Sender name", with: @mail_entry.sender_name
    fill_in "Victim race", with: @mail_entry.victim_race
    fill_in "Inquiry Type", with: @mail_entry.inquiryType
    fill_in "PDF", with: @mail_entry.pdf
    click_on "Update Mail entry"

    assert_text "Mail entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Mail entry" do
    visit mail_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mail entry was successfully deleted."
  end
end
