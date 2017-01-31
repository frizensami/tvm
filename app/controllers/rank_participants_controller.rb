class RankParticipantsController < ApplicationController
  before_action :set_rank_participant, only: [:show, :edit, :update, :destroy]
  include RankParticipantsHelper
  # GET /rank_participants
  # GET /rank_participants.json
  def index
    @rank_participants = RankParticipant.all.reverse
    @rank_participant = RankParticipant.new
    @missing = missing_numbers
  end

  # GET /rank_participants/1
  # GET /rank_participants/1.json
  def show
  end

  # GET /rank_participants/new
  def new
    @rank_participant = RankParticipant.new
  end

  # GET /rank_participants/1/edit
  def edit
  end


  # POST /rank_participants
  # POST /rank_participants.json
  def create
    if params[:commit] == "Force Submit"
      @rank_participant = RankParticipant.new(rank_participant_params)
      @rank_participant.name = "HARD CREATED!" if @rank_participant.name.blank?
      respond_to do |format|
        if @rank_participant.save
          format.html { redirect_to @rank_participant, notice: 'Rank participant was successfully created.' }
          format.json { render :show, status: :created, location: @rank_participant }
        else
          format.html { render :new }
          format.json { render json: @rank_participant.errors, status: :unprocessable_entity }
          format.js { render json: @rank_participant.errors, status: :unprocessable_entity }
        end
      end
    else
      self.soft_create(rank_participant_params)
    end

  end

  # PATCH/PUT /rank_participants/1
  # PATCH/PUT /rank_participants/1.json
  def update
    respond_to do |format|
      if @rank_participant.update(rank_participant_params)
        format.html { redirect_to @rank_participant, notice: 'Rank participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @rank_participant }
      else
        format.html { render :edit }
        format.json { render json: @rank_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rank_participants/1
  # DELETE /rank_participants/1.json
  def destroy
    @rank_participant.destroy
    respond_to do |format|
      format.html { redirect_to rank_participants_url, notice: 'Rank participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #lists ALL the deleted participants in order so that we can undo
  def undolist
    @rank_participants = RankParticipant.only_deleted.reverse
  end

  #controller to fully delete a participant
  def undo_deletion
    RankParticipant.only_deleted.find(params[:id]).restore

    respond_to do |format|
      format.html { redirect_to rank_participants_url, notice: 'RankParticipant was successfully recovered.' }
      format.json { head :no_content }
    end
  end

  #controller to fully delete a participant
  def really_delete
    RankParticipant.only_deleted.find(params[:id]).really_destroy!

    respond_to do |format|
      format.html { redirect_to rank_participants_url, notice: 'RankParticipant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  #checks the order of the ranks and gets the ranks that are not filled in yet
  def check_order
    rps = RankParticipant.all

    #sort the rank participants and extract an array of only the ranks (that are sorted)
    all_ranks_sorted = rps.sort_by { |x| [x.rank] }.map { |rp| rp.rank }

    #array of missing ranks
    @missing = []

    all_ranks_sorted.each_with_index do |item, index|
      if index > 0
        #difference between consecutive ranks, should be 1
        difference = all_ranks_sorted[index] - all_ranks_sorted[index - 1]

        if difference > 1
         @missing.concat(((all_ranks_sorted[index - 1] + 1)...(all_ranks_sorted[index])).to_a)
        end
      end
    end
  end
 #check existence of participant bib number before creating
    def soft_create(rank_participant_params)

      @rank_participant = RankParticipant.new(rank_participant_params)

      @rank_participant.name = Participant.where(bib_number: rank_participant_params[:bib_number]).first.name || "Cannot find name!"

      #Check for rank participant as existent in the participants list, and make sure we don't enter a cancelled
      #rank chip number
      respond_to do |format|
        if Participant.find_by(bib_number: @rank_participant.bib_number) &&
           !(missing_numbers.include?(@rank_participant.rank)) &&
           @rank_participant.save

          format.html { redirect_to @rank_participant, notice: 'Rank participant was successfully created.' }
          format.json { render :show, status: :created, location: @rank_participant }
        else
          p @rank_participant.errors
          format.html { render :new }
          format.json { render json: @rank_participant.errors, status: :unprocessable_entity }
          format.js { render json: @rank_participant.errors, status: :unprocessable_entity }
        end
      end
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rank_participant
      @rank_participant = RankParticipant.find(params[:id])
    end

    def cannot_register_missing_rank
      if missing_numbers.include?(self.rank)
        errors.add(:rank, "is missing! Confirm with the rank chip giver that this rank is cancelled.")
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rank_participant_params
      params.require(:rank_participant).permit(:rank, :name, :bib_number)
    end


end
