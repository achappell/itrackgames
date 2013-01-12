class AddCachedAtToGames < ActiveRecord::Migration
  def change
    add_column :games, :cached_at, :datetime
  end
end
