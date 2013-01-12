require 'nokogiri'
require 'open-uri'

class PlatformsController < ApplicationController
  # GET /platforms
  # GET /platforms.json
  def index
    xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatformsList.php'))
    platformNodes = xml.xpath("//Platforms").to_xml()

    Platform.many_from_xml platformNodes, [:create, :update]

    @platforms = Platform.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @platforms }
    end
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
    @platform = Platform.find(params[:id])

    if @platform.cached_at == nil || @platform.cached_at < (Time.now - 24.hours)
      xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatform.php?id='+@platform.id.to_s))
      platformNodes = xml.xpath("//Platform").first

      Platform.one_from_xml platformNodes.to_xml(), [:update]
      @platform.cached_at = Time.now
      @platform.save

      @platform = Platform.find(params[:id])

      xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatformGames.php?platform='+@platform.id.to_s))
      rootNode = xml.root
       rootNode.node_name = "Games"

      rootNode.children().each do |child|
        platformIdNode = Nokogiri::XML::Node.new "platform_id", xml
        platformIdNode.content = @platform.id
        child.add_child(platformIdNode)
      end

      games = Game.many_from_xml rootNode, [:create, :update]

      games.each do |game|
        game.platform_id = @platform.id
      end
    end 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/new
  # GET /platforms/new.json
  def new
    @platform = Platform.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/1/edit
  def edit
    @platform = Platform.find(params[:id])
  end

  # POST /platforms
  # POST /platforms.json
  def create
    @platform = Platform.new(params[:platform])

    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: 'Platform was successfully created.' }
        format.json { render json: @platform, status: :created, location: @platform }
      else
        format.html { render action: "new" }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /platforms/1
  # PUT /platforms/1.json
  def update
    @platform = Platform.find(params[:id])

    respond_to do |format|
      if @platform.update_attributes(params[:platform])
        format.html { redirect_to @platform, notice: 'Platform was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platforms/1
  # DELETE /platforms/1.json
  def destroy
    @platform = Platform.find(params[:id])
    @platform.destroy

    respond_to do |format|
      format.html { redirect_to platforms_url }
      format.json { head :no_content }
    end
  end
end
