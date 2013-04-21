class Image < ActiveRecord::Base
  attr_accessible :location, :type
  has_one :game_image
  has_one :platform_image

  def as_json(options = {})
    {
      id:  			self.id,
      location:    	self.location,
      type:       	self.type
    }
  end
end
