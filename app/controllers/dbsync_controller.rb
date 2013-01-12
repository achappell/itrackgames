require 'open-uri'
require 'rubygems'
gem 'data_active'
require 'nokogiri'

class DbsyncController < ApplicationController
  def index
 #    xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatformsList.php'))
 #    platformNodes = xml.xpath("//Platforms").to_xml()

 #    Platform.many_from_xml platformNodes, [:create, :update]

 #    @platforms = Platform.all

 #    @platforms.each do |platform|
	#     xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatform.php?id='+platform.id.to_s))
	#     platformNodes = xml.xpath("//Platform").first

	#     @platform = Platform.one_from_xml platformNodes.to_xml(), [:update]

	#     xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatformGames.php?platform='+platform.id.to_s))
	#     rootNode = xml.root
	#     rootNode.node_name = "Games"

	#     rootNode.children().each do |child|
	#       platformIdNode = Nokogiri::XML::Node.new "platform_id", xml
	#      platformIdNode.content = platform.id
	#       child.add_child(platformIdNode)
	#     end

	#     games = Game.many_from_xml rootNode, [:create, :update]

	#     games.each do |game|
	#       game.platform_id = @platform.id
	#     end
	# end

	@games = Game.all

	@games.each do |game|
		xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetGame.php?id='+game.id.to_s))
    	gameNodes = xml.xpath("//Game").first

   		Game.one_from_xml gameNodes.to_xml(), [:update]
   	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end
end
