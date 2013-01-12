class AddCachedAtToPlatforms < ActiveRecord::Migration
  def change
    add_column :platforms, :cached_at, :datetime
  end
end
