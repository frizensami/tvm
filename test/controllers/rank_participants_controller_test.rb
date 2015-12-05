require 'test_helper'

class RankParticipantsControllerTest < ActionController::TestCase
  setup do
    @rank_participant = rank_participants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rank_participants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rank_participant" do
    assert_difference('RankParticipant.count') do
      post :create, rank_participant: { bib_number: @rank_participant.bib_number, name: @rank_participant.name, rank: @rank_participant.rank }
    end

    assert_redirected_to rank_participant_path(assigns(:rank_participant))
  end

  test "should show rank_participant" do
    get :show, id: @rank_participant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rank_participant
    assert_response :success
  end

  test "should update rank_participant" do
    patch :update, id: @rank_participant, rank_participant: { bib_number: @rank_participant.bib_number, name: @rank_participant.name, rank: @rank_participant.rank }
    assert_redirected_to rank_participant_path(assigns(:rank_participant))
  end

  test "should destroy rank_participant" do
    assert_difference('RankParticipant.count', -1) do
      delete :destroy, id: @rank_participant
    end

    assert_redirected_to rank_participants_path
  end
end
