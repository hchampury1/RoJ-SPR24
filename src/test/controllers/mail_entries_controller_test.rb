require 'test_helper'

class MailEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mail_entry = mail_entries(:one)
  end

  test "should get index" do
    get mail_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_mail_entry_url
    assert_response :success
  end

  test "should create mail_entry" do
    assert_difference('MailEntry.count') do
      post mail_entries_url, params: { mail_entry: { case_status: @mail_entry.case_status, crime_age: @mail_entry.crime_age, current_age: @mail_entry.current_age, date: @mail_entry.date, inmate_id: @mail_entry.inmate_id, label: @mail_entry.label, offender_race: @mail_entry.offender_race, sender_name: @mail_entry.sender_name, victim_race: @mail_entry.victim_race, inquiryType: @mail_entry.inquiryType, pdf: @mail_entry.pdf } }
    end

    assert_redirected_to mail_entry_url(MailEntry.last)
  end

  test "should show mail_entry" do
    get mail_entry_url(@mail_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_mail_entry_url(@mail_entry)
    assert_response :success
  end

  test "should update mail_entry" do
    patch mail_entry_url(@mail_entry), params: { mail_entry: { case_status: @mail_entry.case_status, crime_age: @mail_entry.crime_age, current_age: @mail_entry.current_age, date: @mail_entry.date, inmate_id: @mail_entry.inmate_id, label: @mail_entry.label, offender_race: @mail_entry.offender_race, sender_name: @mail_entry.sender_name, victim_race: @mail_entry.victim_race } }
    assert_redirected_to mail_entry_url(@mail_entry)
  end

  test "should destroy mail_entry" do
    assert_difference('MailEntry.count', -1) do
      delete mail_entry_url(@mail_entry)
    end

    assert_redirected_to mail_entries_url
  end
end
