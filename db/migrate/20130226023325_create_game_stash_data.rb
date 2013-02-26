class CreateGameStashData < ActiveRecord::Migration
  def change
    create_table :game_stash_data do |t|
      t.integer :rating
      t.references :games 
      t.references :users

      t.timestamps
    end
  end
end
