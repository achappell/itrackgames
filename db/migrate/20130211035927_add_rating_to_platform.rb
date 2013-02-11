class AddRatingToPlatform < ActiveRecord::Migration
  def change
  	add_column :platforms, :rating, :string
  end
end
