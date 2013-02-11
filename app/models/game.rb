class Game < ActiveRecord::Base
  belongs_to :platform, :inverse_of => :games
  has_many :game_images
  has_many :images, through: :game_images
  attr_accessible :ESRB, :GameTitle, :Overview, :Platform, :platform_id, :ReleaseDate, :Players, :Publisher, :Developer, :Rating
end
