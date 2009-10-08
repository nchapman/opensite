require 'test_helper'

class JavascriptsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:javascripts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create javascript" do
    assert_difference('Javascript.count') do
      post :create, :javascript => { }
    end

    assert_redirected_to javascript_path(assigns(:javascript))
  end

  test "should show javascript" do
    get :show, :id => javascripts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => javascripts(:one).to_param
    assert_response :success
  end

  test "should update javascript" do
    put :update, :id => javascripts(:one).to_param, :javascript => { }
    assert_redirected_to javascript_path(assigns(:javascript))
  end

  test "should destroy javascript" do
    assert_difference('Javascript.count', -1) do
      delete :destroy, :id => javascripts(:one).to_param
    end

    assert_redirected_to javascripts_path
  end
end
