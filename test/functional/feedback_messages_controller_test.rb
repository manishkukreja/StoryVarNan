require 'test_helper'

class FeedbackMessagesControllerTest < ActionController::TestCase
  setup do
    @feedback_message = feedback_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feedback_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feedback_message" do
    assert_difference('FeedbackMessage.count') do
      post :create, :feedback_message => @feedback_message.attributes
    end

    assert_redirected_to feedback_message_path(assigns(:feedback_message))
  end

  test "should show feedback_message" do
    get :show, :id => @feedback_message.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @feedback_message.to_param
    assert_response :success
  end

  test "should update feedback_message" do
    put :update, :id => @feedback_message.to_param, :feedback_message => @feedback_message.attributes
    assert_redirected_to feedback_message_path(assigns(:feedback_message))
  end

  test "should destroy feedback_message" do
    assert_difference('FeedbackMessage.count', -1) do
      delete :destroy, :id => @feedback_message.to_param
    end

    assert_redirected_to feedback_messages_path
  end
end
