class RanksController < ApplicationController
  before_action :set_rank, only: [:show, :edit, :update, :destroy]

  # GET /ranks
  # GET /ranks.json
  def index
    @ranks = Rank.all.reverse
    @rank = Rank.new
  end

  # GET /ranks/1
  # GET /ranks/1.json
  def show
  end

  # GET /ranks/new
  def new
    @rank = Rank.new
  end

  # GET /ranks/1/edit
  def edit
  end

  # POST /ranks
  # POST /ranks.json
  def create
    @rank = Rank.new(rank_params)

    respond_to do |format|
      if @rank.save
        format.html { redirect_to @rank, notice: 'Rank was successfully created.' }
        format.json { render :show, status: :created, location: @rank }
      else
        format.html { render :new }
        format.json { render json: @rank.errors, status: :unprocessable_entity }
        format.js { render json: @rank.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /ranks/1
  # PATCH/PUT /ranks/1.json
  def update
    respond_to do |format|
      if @rank.update(rank_params)
        format.html { redirect_to @rank, notice: 'Rank was successfully updated.' }
        format.json { render :show, status: :ok, location: @rank }
      else
        format.html { render :edit }
        format.json { render json: @rank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranks/1
  # DELETE /ranks/1.json
  def destroy
    @rank.destroy
    respond_to do |format|
      format.html { redirect_to ranks_url, notice: 'Rank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #lists ALL the deleted Ranks in order so that we can undo
  def undolist
    @ranks = Rank.only_deleted.reverse
  end

  #controller to fully delete a Rank
  def undo_deletion
    Rank.only_deleted.find(params[:id]).restore

    respond_to do |format|
      format.html { redirect_to ranks_url, notice: 'Rank was successfully recovered.' }
      format.json { head :no_content }
    end
  end

  #controller to fully delete a Rank
  def really_delete
    Rank.only_deleted.find(params[:id]).really_destroy!

    respond_to do |format|
      format.html { redirect_to ranks_url, notice: 'Rank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def auto
    @ranks = Rank.all
    @new_rank = Rank.new

    # Current time
    Time.zone = "Singapore"
    time_now = Time.zone.now

    # Edit the new_rank to be added to the database
    if @ranks.blank?
      @new_rank.rank = 1  
    else
      @new_rank.rank = @ranks.last.rank + 1
    end
    @new_rank.end_time = time_now
    @new_rank.created_at = time_now
    @new_rank.updated_at = time_now

    respond_to do |format|
      if @new_rank.save
        format.html { redirect_to @new_rank, notice: 'Rank was successfully created.' }
        format.json { render :show, status: :created, location: @new_rank }
      else
        format.html { render :new }
        format.json { render json: @new_rank.errors, status: :unprocessable_entity }
      end
    end
  end


  def update_nums
    @ranks = Rank.all
    @new_ranks = @ranks.sort_by { |x| [x.end_time] }

    #render plain: @new_ranks.inspect

    counter = 1
    @new_ranks.each do |new_rank|
      new_rank.update_attribute(:rank, counter)
      counter = counter + 1
    end

    render plain: @new_ranks.inspect

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rank
      @rank = Rank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rank_params
      params.require(:rank).permit(:rank, :end_time)
    end
end
