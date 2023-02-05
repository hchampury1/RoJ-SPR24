require "application_system_test_case"

class RemindersTest < ApplicationSystemTestCase
  setup do
    @reminder = reminders(:one)
  end

  test "visiting the index" do
    visit reminders_url
    assert_selector "h1", text: "Reminders"
  end

  test "creating a Reminder" do
    visit reminders_url
    click_on "New Reminder"

    fill_in "Mail entry", with: @reminder.mail_entry_id
    fill_in "Notes", with: @reminder.notes
    fill_in "Priority", with: @reminder.priority
    fill_in "Reminder time", with: @reminder.reminder_time
    fill_in "User email", with: @reminder.user_email
    fill_in "Username", with: @reminder.username
    click_on "Create Reminder"

    assert_text "Reminder was successfully created"
    click_on "Back"
  end

  test "updating a Reminder" do
    visit reminders_url
    click_on "Edit", match: :first

    fill_in "Mail entry", with: @reminder.mail_entry_id
    fill_in "Notes", with: @reminder.notes
    fill_in "Priority", with: @reminder.priority
    fill_in "Reminder time", with: @reminder.reminder_time
    fill_in "User email", with: @reminder.user_email
    fill_in "Username", with: @reminder.username
    click_on "Update Reminder"

    assert_text "Reminder was successfully updated"
    click_on "Back"
  end

  test "destroying a Reminder" do
    visit reminders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reminder was successfully deleted."
  end
end
