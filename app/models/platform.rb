require 'open-uri'

class Platform < ActiveRecord::Base
  has_many :games, :dependent => :destroy, :inverse_of => :platform
  attr_accessible :name, :overview, :developer, :cached_at

  def add_game(game_hash)

    @game = games.where(:id => game_hash["id"]).first

    if @game.nil?
  	 @game = games.build(title: game_hash["GameTitle"], id: game_hash["id"])
    end

    if game_hash["Images"]
     images = game_hash["Images"].first
     images = images["fanart"]

     puts images

      images.each do |image|
        location = image["thumb"].first()
        puts location
        @game.images.build(location: location)
      end
    end

  	@game
  end

  def add_all_games

    xml = open('http://thegamesdb.net/api/GetPlatformGames.php?platform='+self.id.to_s)

    game_data = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Data' })

    #puts game_data["Game"]

    gameInfo = game_data["Game"]

    gameInfo.each do |game|
      self.add_game(game).save

    end

    self.games

  end
end
