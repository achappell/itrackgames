module SearchHelper

def search_games(search_term)

	xml = open('http://thegamesdb.net/api/GetGamesList.php?name='+URI::escape(search_term.to_s))

    game_data = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Data' })

    gameInfo = game_data["Game"]

    search_results = [];

    gameInfo.each do |game|

    	platform = Platform.where(:name => game["Platform"]).first

    	puts platform

      	search_results << platform.add_game(game)

    end

    search_results

end

end
