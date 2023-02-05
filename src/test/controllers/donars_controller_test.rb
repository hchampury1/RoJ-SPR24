require 'test_helper'

class DonarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donar = donars(:one)
  end

  test "should get index" do
    get donars_url
    assert_response :success
  end

  test "should get new" do
    get new_donar_url
    assert_response :success
  end

  test "should create donar" do
    assert_difference('Donar.count') do
      post donars_url, params: { donar: { email: @donar.email, location: @donar.location, name: @donar.name, phoneNumber: @donar.phoneNumber } }
    end

    assert_redirected_to donar_url(Donar.last)
  end

  test "should show donar" do
    get donar_url(@donar)
    assert_response :success
  end

  test "should get edit" do
    get edit_donar_url(@donar)
    assert_response :success
  end

  test "should update donar" do
    patch donar_url(@donar), params: { donar: { email: @donar.email, location: @donar.location, name: @donar.name, phoneNumber: @donar.phoneNumber } }
    assert_redirected_to donar_url(@donar)
  end

  test "should destroy donar" do
    assert_difference('Donar.count', -1) do
      delete donar_url(@donar)
    end

    assert_redirected_to donars_url
  end
end
