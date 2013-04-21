class PlatformImage < ActiveRecord::Base
  belongs_to :platform
  belongs_to :image
  # attr_accessible :title, :body
end
