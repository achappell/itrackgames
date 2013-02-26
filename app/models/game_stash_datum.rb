class GameStashDatum < ActiveRecord::Base
	belongs_to :game
	belongs_to :user

  	attr_accessible :rating, :game_id, :user_id
end
