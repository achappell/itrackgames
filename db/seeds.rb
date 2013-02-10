# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'

GC.disable

Platform.delete_all
Game.delete_all

xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatformsList.php'))
    platformNodes = xml.xpath("//Platforms").to_xml()

Platform.many_from_xml platformNodes, [:create, :update]

@platforms = Platform.all

@platforms.each do |platform|
	xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatform.php?id='+platform.id.to_s))
	platformNodes = xml.xpath("//Platform").first

    @platform = Platform.one_from_xml platformNodes.to_xml(), [:update]

 	puts platform.name

    xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetPlatformGames.php?platform='+platform.id.to_s))
    rootNode = xml.root
    rootNode.node_name = "Games"

    rootNode.children().each do |child|
      	platformIdNode = Nokogiri::XML::Node.new "platform_id", xml
     	platformIdNode.content = platform.id
      	child.add_child(platformIdNode)
    end

    games = Game.many_from_xml rootNode, [:create, :update]

    games.each do |game|
      	game.platform_id = @platform.id
    end

    puts "Platform Finished"
end

@games = Game.all

@games.each do |game|
	xml = Nokogiri::XML(open('http://thegamesdb.net/api/GetGame.php?id='+game.id.to_s))
	gameNodes = xml.xpath("//Game").first

	Game.one_from_xml gameNodes.to_xml(), [:update]
end