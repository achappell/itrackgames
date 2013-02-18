class AddExternalIdToGames < ActiveRecord::Migration
  def change
  	add_column :games, :external_id, :integer
  	add_column :platforms, :external_id, :integer
  end
end
