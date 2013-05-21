require 'test_helper'

class ReadingListsControllerTest < ActionController::TestCase
  setup do
    @reading_list = reading_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reading_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reading_list" do
    assert_difference('ReadingList.count') do
      post :create, reading_list: @reading_list.attributes
    end

    assert_redirected_to reading_list_path(assigns(:reading_list))
  end

  test "should show reading_list" do
    get :show, id: @reading_list.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reading_list.to_param
    assert_response :success
  end

  test "should update reading_list" do
    put :update, id: @reading_list.to_param, reading_list: @reading_list.attributes
    assert_redirected_to reading_list_path(assigns(:reading_list))
  end

  test "should destroy reading_list" do
    assert_difference('ReadingList.count', -1) do
      delete :destroy, id: @reading_list.to_param
    end

    assert_redirected_to reading_lists_path
  end
end
