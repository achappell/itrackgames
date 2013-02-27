class CreateGameStashData < ActiveRecord::Migration
  def change
    create_table :game_stash_data do |t|
      t.integer :rating
      t.boolean :has_played
      t.references :games 
      t.references :users

      t.timestamps
    end
  end
end
