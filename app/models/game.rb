class Game < ActiveRecord::Base
  belongs_to :platform, :inverse_of => :games
  has_many :game_images
  has_many :images, through: :game_images
  attr_accessible :esrb, :title, :overview, :platform, :platform_id, :release_date, :players, :publisher, :developer, :rating
end
