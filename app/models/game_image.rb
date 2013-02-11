class GameImage < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :game
  belongs_to :image
end
