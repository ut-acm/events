require 'test_helper'

class OfficershipsControllerTest < ActionController::TestCase
  setup do
    @officership = officerships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:officerships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create officership" do
    assert_difference('Officership.count') do
      post :create, officership: { description: @officership.description, event_id: @officership.event_id, profile_id: @officership.profile_id }
    end

    assert_redirected_to officership_path(assigns(:officership))
  end

  test "should show officership" do
    get :show, id: @officership
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @officership
    assert_response :success
  end

  test "should update officership" do
    patch :update, id: @officership, officership: { description: @officership.description, event_id: @officership.event_id, profile_id: @officership.profile_id }
    assert_redirected_to officership_path(assigns(:officership))
  end

  test "should destroy officership" do
    assert_difference('Officership.count', -1) do
      delete :destroy, id: @officership
    end

    assert_redirected_to officerships_path
  end
end
