require 'test_helper'

class WavesControllerTest < ActionController::TestCase
  setup do
    @wave = waves(:one)
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

  test "should create wave" do
    assert_difference('Wave.count') do
      post :create, wave: { start_time: @wave.start_time, wave_number: @wave.wave_number }
    end

    assert_redirected_to wave_path(assigns(:wave))
  end

  test "should show wave" do
    get :show, id: @wave
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wave
    assert_response :success
  end

  test "should update wave" do
    patch :update, id: @wave, wave: { start_time: @wave.start_time, wave_number: @wave.wave_number }
    assert_redirected_to wave_path(assigns(:wave))
  end

  test "should destroy wave" do
    assert_difference('Wave.count', -1) do
      delete :destroy, id: @wave
    end

    assert_redirected_to waves_path
  end
end
