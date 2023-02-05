require 'test_helper'

class inkindControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inkind = inkind(:one)
  end

  test "should get index" do
    get inkind_url
    assert_response :success
  end

  test "should get new" do
    get new_inkind_url
    assert_response :success
  end

  test "should create inkind" do
    assert_difference('Inkind.count') do
      post inkind_url, params: { inkind: { date: @inkind.date, description: @inkind.description, name: @inkind.name, type: @inkind.genre, user: @inkind.user, value: @inkind.value } }
    end

    assert_redirected_to inkind_url(Inkind.last)
  end

  test "should show inkind" do
    get inkind_url(@inkind)
    assert_response :success
  end

  test "should get edit" do
    get edit_inkind_url(@inkind)
    assert_response :success
  end

  test "should update inkind" do
    patch inkind_url(@inkind), params: { inkind: { date: @inkind.date, description: @inkind.description, name: @inkind.name, type: @inkind.genre, user: @inkind.user, value: @inkind.value } }
    assert_redirected_to inkind_url(@inkind)
  end

  test "should destroy inkind" do
    assert_difference('Inkind.count', -1) do
      delete inkind_url(@inkind)
    end

    assert_redirected_to inkind_url
  end
end
