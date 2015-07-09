require 'test_helper'

class PriceModelsControllerTest < ActionController::TestCase
  setup do
    @price_model = price_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:price_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create price_model" do
    assert_difference('PriceModel.count') do
      post :create, price_model: { event_id: @price_model.event_id, name: @price_model.name, price: @price_model.price }
    end

    assert_redirected_to price_model_path(assigns(:price_model))
  end

  test "should show price_model" do
    get :show, id: @price_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @price_model
    assert_response :success
  end

  test "should update price_model" do
    patch :update, id: @price_model, price_model: { event_id: @price_model.event_id, name: @price_model.name, price: @price_model.price }
    assert_redirected_to price_model_path(assigns(:price_model))
  end

  test "should destroy price_model" do
    assert_difference('PriceModel.count', -1) do
      delete :destroy, id: @price_model
    end

    assert_redirected_to price_models_path
  end
end
