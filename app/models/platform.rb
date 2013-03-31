require 'open-uri'

class Platform < ActiveRecord::Base
  has_many :games, :dependent => :destroy, :inverse_of => :platform
  attr_accessible :external_id, :name, :overview, :developer, :cached_at

  def add_game(game_hash)

    id = game_hash["id"].first

    if Game.where(:external_id => id).exists?
  	   @game = Game.find_by_external_id(id)
    else
       @game = games.build(title: game_hash["GameTitle"], external_id: id)
    end

    if game_hash["GameTitle"]
      @game.title = game_hash["GameTitle"].first
    end

    if game_hash["ReleaseDate"]
      @game.release_date = game_hash["ReleaseDate"].first
    end

    if game_hash["Publisher"]
      @game.publisher = game_hash["Publisher"].first
    end

    if game_hash["Developer"]
      @game.developer = game_hash["Developer"].first
    end

    if game_hash["Overview"]
      @game.overview = game_hash["Overview"].first
    end

    @game.images.clear

    if game_hash["Images"]
     images = game_hash["Images"].first

      if images["boxart"]
        boxart = images["boxart"]
    
        boxart.each do |image|
          location = "http://thegamesdb.net/banners/" + image["thumb"]
          updated_game = @game.images.build(location: location)
          updated_game.save
        end
      end

      if images["fanart"]
        fanart = images["fanart"]

        fanart.each do |image|
          thumb_image = image["thumb"].first
          location = "http://thegamesdb.net/banners/" + thumb_image
          updated_game = @game.images.build(location: location)
          updated_game.save
        end
      end
    end

    @game.cached_at = Time.now

  	@game
  end

  def add_all_games

    xml = open('http://thegamesdb.net/api/GetPlatformGames.php?platform='+self.external_id.to_s)

    game_data = XmlSimple.xml_in(xml, { 'KeyAttr' => 'Data' })

  if game_data["Game"]
      gameInfo = game_data["Game"]

      gameInfo.each do |game|
        self.add_game(game).save
      end
  end

  self.games

  end
end
