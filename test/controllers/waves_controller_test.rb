require 'test_helper'

class WavesControllerTest < ActionController::TestCase
  setup do
    @wafe = waves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:waves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wafe" do
    assert_difference('Wave.count') do
      post :create, wafe: { start_time: @wafe.start_time, wave_number: @wafe.wave_number }
    end

    assert_redirected_to wafe_path(assigns(:wafe))
  end

  test "should show wafe" do
    get :show, id: @wafe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wafe
    assert_response :success
  end

  test "should update wafe" do
    patch :update, id: @wafe, wafe: { start_time: @wafe.start_time, wave_number: @wafe.wave_number }
    assert_redirected_to wafe_path(assigns(:wafe))
  end

  test "should destroy wafe" do
    assert_difference('Wave.count', -1) do
      delete :destroy, id: @wafe
    end

    assert_redirected_to waves_path
  end
end
