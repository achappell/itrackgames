class Game < ActiveRecord::Base
  belongs_to :platform, :inverse_of => :games
  has_many :game_images
  has_many :images, through: :game_images
  has_many :game_stash_datum
  has_many :users, :through => :game_stash_datum
  attr_accessible :external_id, :esrb, :title, :overview, :platform, :platform_id, :release_date, :players, :publisher, :developer, :rating

  def as_json(options = {})
    {
      id:           	self.id,
      title:         	self.title,
      overview:     	self.overview,
      esrb:    			self.esrb,
      platform:  		self.platform,
      platform_id:      self.platform_id,
      release_date: 	self.release_date,
      players: 			self.players,
      publisher: 		self.publisher,
      developer: 		self.developer,
      rating: 			self.rating
    }
  end

end
