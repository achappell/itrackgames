include PlatformsHelper
require 'open-uri'
require '_settings.rb'

class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index

    if params[:platform_id]
      if Settings.pull_from_external == 1
        @platform = fetch_platform(params[:platform_id])
        @platform.add_all_games
      end

      @games = Game.find_all_by_platform_id(params[:platform_id])
    else
      @games = Game.all
    end

    gamesArrayJson = [];

    @games.each do |game|

      gamesHash = JSON.parse(game.to_json)

      if current_user && GameStashDatum.exists?(:game_id => game.id)
        game_stash_datum = GameStashDatum.find_by_user_id_and_game_id(current_user.id, game.id)
        gamesHash["game_stash_datum"] = game_stash_datum
      else
        gamesHash["game_stash_datum"] = {:has_played => false, :rating => 0};
      end

      gamesArrayJson << gamesHash

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: gamesArrayJson }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    @platform = Platform.find(@game.platform_id)
    
    #if @game.cached_at == nil || @game.cached_at < (Time.now - 24.hours)
      xml = open('http://thegamesdb.net/api/GetGame.php?id='+@game.external_id.to_s)

      require 'xmlsimple'
      gameData = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Game' })
      gameInfo = gameData["Game"].first

      @game = @platform.add_game(gameInfo)

    #end

    jsonHash = JSON.parse(@game.to_json)
    jsonHash["images"] = @game.images

    if current_user && GameStashDatum.exists?(:game_id => @game.id)
      game_stash_datum = GameStashDatum.find_by_user_id_and_game_id(current_user.id, @game.id)
      jsonHash["game_stash_datum"] = game_stash_datum
    else
      jsonHash["game_stash_datum"] = {:has_played => false, :rating => 0};
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: jsonHash }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @platform = Platform.find(params[:platform_id])
    @game = @platform.games.create(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to platform_path(@platform), notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end
end
