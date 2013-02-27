class GameStashDataController < ApplicationController
  before_filter :authenticate_user!

  # GET /game_stash_data
  # GET /game_stash_data.json
  def index
    @game_stash_data = GameStashDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_stash_data }
    end
  end

  # GET /game_stash_data/1
  # GET /game_stash_data/1.json
  def show
    @game_stash_datum = GameStashDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_stash_datum }
    end
  end

  # GET /game_stash_data/new
  # GET /game_stash_data/new.json
  def new
    @game_stash_datum = GameStashDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_stash_datum }
    end
  end

  # GET /game_stash_data/1/edit
  def edit
    @game_stash_datum = GameStashDatum.find(params[:id])
  end

  # POST /game_stash_data
  # POST /game_stash_data.json
  def create

    if GameStashDatum.exists?(:user_id => params[:user_id], :game_id => params[:game_id])
      @game_stash_datum = GameStashDatum.find_by_user_id_and_game_id(params[:user_id], params[:game_id])
    else
      @game_stash_datum = GameStashDatum.new(params[:game_stash_datum])
      @game_stash_datum.user_id = params[:user_id]
      @game_stash_datum.game_id = params[:game_id]
    end

    @game_stash_datum.has_played = params.has_key?(:check)

    respond_to do |format|
      if @game_stash_datum.save
        format.html { redirect_to @game_stash_datum, notice: 'Game stash datum was successfully created.' }
        format.json { render json: @game_stash_datum, status: :created, location: @game_stash_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @game_stash_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_stash_data/1
  # PUT /game_stash_data/1.json
  def update
    @game_stash_datum = GameStashDatum.find(params[:id])

    respond_to do |format|
      if @game_stash_datum.update_attributes(params[:game_stash_datum])
        format.html { redirect_to @game_stash_datum, notice: 'Game stash datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_stash_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_stash_data/1
  # DELETE /game_stash_data/1.json
  def destroy
    @game_stash_datum = GameStashDatum.find(params[:id])
    @game_stash_datum.destroy

    respond_to do |format|
      format.html { redirect_to game_stash_data_url }
      format.json { head :no_content }
    end
  end
end
