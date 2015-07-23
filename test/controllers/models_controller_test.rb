require 'test_helper'

class ModelsControllerTest < ActionController::TestCase
  setup do
    @model = models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create model" do
    assert_difference('Model.count') do
      post :create, model: { PayIt: @model.PayIt, city: @model.city, email: @model.email, exam_overall_rank: @model.exam_overall_rank, exam_regional_rank: @model.exam_regional_rank, grades_image: @model.grades_image, mobile: @model.mobile, name: @model.name, payment_id: @model.payment_id, region_type: @model.region_type, school: @model.school, surname: @model.surname }
    end

    assert_redirected_to model_path(assigns(:model))
  end

  test "should show model" do
    get :show, id: @model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @model
    assert_response :success
  end

  test "should update model" do
    patch :update, id: @model, model: { PayIt: @model.PayIt, city: @model.city, email: @model.email, exam_overall_rank: @model.exam_overall_rank, exam_regional_rank: @model.exam_regional_rank, grades_image: @model.grades_image, mobile: @model.mobile, name: @model.name, payment_id: @model.payment_id, region_type: @model.region_type, school: @model.school, surname: @model.surname }
    assert_redirected_to model_path(assigns(:model))
  end

  test "should destroy model" do
    assert_difference('Model.count', -1) do
      delete :destroy, id: @model
    end

    assert_redirected_to models_path
  end
end
