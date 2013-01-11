class RemovePlatformIdFromPlatform < ActiveRecord::Migration
  def up
    remove_column :platforms, :platform_id
  end

  def down
    add_column :platforms, :platform_id, :integer
  end
end
