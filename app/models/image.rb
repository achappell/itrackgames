class Image < ActiveRecord::Base
  attr_accessible :location
  has_one :game_image
end
