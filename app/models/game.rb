class Game < ActiveRecord::Base
  belongs_to :platform, :inverse_of => :games
  attr_accessible :ESRB, :GameTitle, :Overview, :Platform, :platform_id
end
