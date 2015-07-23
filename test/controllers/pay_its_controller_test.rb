require 'test_helper'

class PayItsControllerTest < ActionController::TestCase
  setup do
    @pay_it = pay_its(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pay_its)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pay_it" do
    assert_difference('PayIt.count') do
      post :create, pay_it: { city: @pay_it.city, email: @pay_it.email, exam_overall_rank: @pay_it.exam_overall_rank, exam_regional_rank: @pay_it.exam_regional_rank, grades_image: @pay_it.grades_image, mobile: @pay_it.mobile, name: @pay_it.name, payment_id: @pay_it.payment_id, region_type: @pay_it.region_type, school: @pay_it.school, surname: @pay_it.surname }
    end

    assert_redirected_to pay_it_path(assigns(:pay_it))
  end

  test "should show pay_it" do
    get :show, id: @pay_it
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pay_it
    assert_response :success
  end

  test "should update pay_it" do
    patch :update, id: @pay_it, pay_it: { city: @pay_it.city, email: @pay_it.email, exam_overall_rank: @pay_it.exam_overall_rank, exam_regional_rank: @pay_it.exam_regional_rank, grades_image: @pay_it.grades_image, mobile: @pay_it.mobile, name: @pay_it.name, payment_id: @pay_it.payment_id, region_type: @pay_it.region_type, school: @pay_it.school, surname: @pay_it.surname }
    assert_redirected_to pay_it_path(assigns(:pay_it))
  end

  test "should destroy pay_it" do
    assert_difference('PayIt.count', -1) do
      delete :destroy, id: @pay_it
    end

    assert_redirected_to pay_its_path
  end
end
