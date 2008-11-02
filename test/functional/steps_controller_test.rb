require 'test_helper'

class StepsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:steps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_step
    assert_difference('Step.count') do
      post :create, :step => { }
    end

    assert_redirected_to step_path(assigns(:step))
  end

  def test_should_show_step
    get :show, :id => steps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => steps(:one).id
    assert_response :success
  end

  def test_should_update_step
    put :update, :id => steps(:one).id, :step => { }
    assert_redirected_to step_path(assigns(:step))
  end

  def test_should_destroy_step
    assert_difference('Step.count', -1) do
      delete :destroy, :id => steps(:one).id
    end

    assert_redirected_to steps_path
  end
end
