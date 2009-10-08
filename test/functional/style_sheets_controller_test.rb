require 'test_helper'

class StyleSheetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:style_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create style_sheet" do
    assert_difference('StyleSheet.count') do
      post :create, :style_sheet => { }
    end

    assert_redirected_to style_sheet_path(assigns(:style_sheet))
  end

  test "should show style_sheet" do
    get :show, :id => style_sheets(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => style_sheets(:one).to_param
    assert_response :success
  end

  test "should update style_sheet" do
    put :update, :id => style_sheets(:one).to_param, :style_sheet => { }
    assert_redirected_to style_sheet_path(assigns(:style_sheet))
  end

  test "should destroy style_sheet" do
    assert_difference('StyleSheet.count', -1) do
      delete :destroy, :id => style_sheets(:one).to_param
    end

    assert_redirected_to style_sheets_path
  end
end
