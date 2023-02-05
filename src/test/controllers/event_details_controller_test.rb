require 'test_helper'

class EventDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_detail = event_details(:one)
  end

  test "should get index" do
    get event_details_url
    assert_response :success
  end

  test "should get new" do
    get new_event_detail_url
    assert_response :success
  end

  test "should create event_detail" do
    assert_difference('EventDetail.count') do
      post event_details_url, params: { event_detail: { description: @event_detail.description, eventdatetime: @event_detail.eventdatetime, speakers: @event_detail.speakers, title: @event_detail.title } }
    end

    assert_redirected_to event_detail_url(EventDetail.last)
  end

  test "should show event_detail" do
    get event_detail_url(@event_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_detail_url(@event_detail)
    assert_response :success
  end

  test "should update event_detail" do
    patch event_detail_url(@event_detail), params: { event_detail: { description: @event_detail.description, eventdatetime: @event_detail.eventdatetime, speakers: @event_detail.speakers, title: @event_detail.title } }
    assert_redirected_to event_detail_url(@event_detail)
  end

  test "should destroy event_detail" do
    assert_difference('EventDetail.count', -1) do
      delete event_detail_url(@event_detail)
    end

    assert_redirected_to event_details_url
  end
end
