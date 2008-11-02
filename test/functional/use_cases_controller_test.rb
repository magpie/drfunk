require 'test_helper'

class UseCasesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:use_cases)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_use_case
    assert_difference('UseCase.count') do
      post :create, :use_case => { }
    end

    assert_redirected_to use_case_path(assigns(:use_case))
  end

  def test_should_show_use_case
    get :show, :id => use_cases(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => use_cases(:one).id
    assert_response :success
  end

  def test_should_update_use_case
    put :update, :id => use_cases(:one).id, :use_case => { }
    assert_redirected_to use_case_path(assigns(:use_case))
  end

  def test_should_destroy_use_case
    assert_difference('UseCase.count', -1) do
      delete :destroy, :id => use_cases(:one).id
    end

    assert_redirected_to use_cases_path
  end
end
