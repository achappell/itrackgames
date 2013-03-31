require 'rake'

task :importAllData => :environment do
	include PlatformsHelper
	fetch_all_platforms

	platform_count = 0;

	Platform.all.each do |platform|
		platform = fetch_platform(platform.id)
      	platform.add_all_games

      	count = 0;

      	platform.games.each do |game|
      		xml = open('http://thegamesdb.net/api/GetGame.php?id='+game.external_id.to_s)

      		require 'xmlsimple'
      		gameData = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Game' })
      		gameInfo = gameData["Game"].first

      		updatedGame = platform.add_game(gameInfo)
      		updatedGame.save

      		count = count + 1;

      		puts "Game " + count.to_s + " added, " + (platform.games.count - count).to_s + " remain"
      	end

      	platform.save;
      	platform_count = platform_count + 1;

      	puts "Platform " + platform_count.to_s + " added, " + (Platform.all.count - platform_count).to_s + "remain"
	end
end