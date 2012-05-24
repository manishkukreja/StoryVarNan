require 'test_helper'

class TerminologiesControllerTest < ActionController::TestCase
  setup do
    @terminology = terminologies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:terminologies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create terminology" do
    assert_difference('Terminology.count') do
      post :create, :terminology => @terminology.attributes
    end

    assert_redirected_to terminology_path(assigns(:terminology))
  end

  test "should show terminology" do
    get :show, :id => @terminology.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @terminology.to_param
    assert_response :success
  end

  test "should update terminology" do
    put :update, :id => @terminology.to_param, :terminology => @terminology.attributes
    assert_redirected_to terminology_path(assigns(:terminology))
  end

  test "should destroy terminology" do
    assert_difference('Terminology.count', -1) do
      delete :destroy, :id => @terminology.to_param
    end

    assert_redirected_to terminologies_path
  end
end
