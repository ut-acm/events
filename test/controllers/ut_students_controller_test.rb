require 'test_helper'

class UtStudentsControllerTest < ActionController::TestCase
  setup do
    @ut_student = ut_students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ut_students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ut_student" do
    assert_difference('UtStudent.count') do
      post :create, ut_student: { email: @ut_student.email, token: @ut_student.token, validated: @ut_student.validated }
    end

    assert_redirected_to ut_student_path(assigns(:ut_student))
  end

  test "should show ut_student" do
    get :show, id: @ut_student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ut_student
    assert_response :success
  end

  test "should update ut_student" do
    patch :update, id: @ut_student, ut_student: { email: @ut_student.email, token: @ut_student.token, validated: @ut_student.validated }
    assert_redirected_to ut_student_path(assigns(:ut_student))
  end

  test "should destroy ut_student" do
    assert_difference('UtStudent.count', -1) do
      delete :destroy, id: @ut_student
    end

    assert_redirected_to ut_students_path
  end
end
