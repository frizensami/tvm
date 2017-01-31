require 'test_helper'

class RankParticipantsControllerTest < ActionController::TestCase
  setup do
    @rank_participant = rank_participants(:one)

    # Data that is not in Fixtures
    # Create the Yew Siang test data so that the rankparticipant can be created
    @participant_new = Participant.create(bib_number: "MO101", name: "Yew Siang", wave_number: 4)
    # Create a rank participant to add
    @rank_participant_new = RankParticipant.new(rank: 3, name: "Yew Siang", bib_number: "MO101")
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
      post :create, rank_participant: { bib_number: @rank_participant_new.bib_number, name: @rank_participant_new.name, rank: @rank_participant_new.rank }
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
