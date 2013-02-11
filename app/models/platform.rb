class Platform < ActiveRecord::Base
  has_many :games, :dependent => :destroy, :inverse_of => :platform
  attr_accessible :name, :overview, :developer, :cached_at

  def add_game(game_hash)
  	puts 'adding game'
 	
  	gameInfo = game_hash["Game"].first

  	images = gameInfo["Images"].first
  	images = images["fanart"]

  	puts images

  	@game = games.build(GameTitle: gameInfo["GameTitle"].first, Platform: gameInfo["Platform"].first,
  						Overview: gameInfo["Overview"].first, ESRB: gameInfo["ESRB"].first)

  	images.each do |image|
  		location = image["thumb"].first()
  		puts location
  		@game.images.build(location: location)
  	end

  	@game
  end
end
