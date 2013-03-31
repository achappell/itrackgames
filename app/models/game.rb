class Game < ActiveRecord::Base
  belongs_to :platform, :inverse_of => :games
  has_many :game_images
  has_many :images, through: :game_images
  has_many :game_stash_datum
  has_many :users, :through => :game_stash_datum
  attr_accessible :external_id, :esrb, :title, :overview, :platform, :platform_id, :release_date, :players, :publisher, :developer, :rating

end
