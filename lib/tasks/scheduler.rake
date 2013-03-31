require 'rake'

task :importAllData => :environment do
	include PlatformsHelper
	fetch_all_platforms

	platform_count = 0;

	Platform.all.each do |platform|
		platform = fetch_platform(platform.id)
      	platform.add_all_games

      	count = 0;

      	# platform.games.each do |game|
      	# 	xml = open('http://thegamesdb.net/api/GetGame.php?id='+game.external_id.to_s)

      	# 	require 'xmlsimple'
      	# 	gameData = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Game' })
      	# 	gameInfo = gameData["Game"].first

      	# 	updatedGame = platform.add_game(gameInfo)
      	# 	updatedGame.save

      	# 	count = count + 1;

      	# 	puts "Game " + count.to_s + " added, " + (platform.games.count - count).to_s + " remain"
      	# end

      	platform.save;
      	platform_count = platform_count + 1;

      	puts "Platform " + platform_count.to_s + " added, " + (Platform.all.count - platform_count).to_s + "remain"
	end
end

task :import_changed_data => :environment do

      require 'xmlsimple'

      xml = open('http://thegamesdb.net/api/Updates.php?time=90000')

      updateData = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Items'})

      puts updateData

      if (updateData["Game"])
            updateData["Game"].each do |game|

                  game_XML = open('http://thegamesdb.net/api/GetGame.php?id='+game.to_s)
                  gameData = XmlSimple.xml_in(game_XML, { 'KeyAttr' => 'Game' })
                  gameInfo = gameData["Game"].first

                  platform_id = gameInfo["PlatformId"]
                  platform = Platform.find_by_external_id(platform_id)

                  updatedGame = platform.add_game(gameInfo)
                  updatedGame.save
            end
      end
end