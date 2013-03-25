module SearchHelper

def search_games(search_term)

	xml = open('http://thegamesdb.net/api/GetGamesList.php?name='+URI::escape(search_term.to_s))

    game_data = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Data' })

    gameInfo = game_data["Game"]

    search_results = [];

    gameInfo.each do |game|

    	platform = Platform.where(:name => game["Platform"]).first

    	game = platform.add_game(game)
    	game.save
      	search_results << game

    end

    search_results

end

end
