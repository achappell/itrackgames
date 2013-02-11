class CreateGameImages < ActiveRecord::Migration
  def change
    create_table :game_images do |t|
    	t.references :game
    	t.references :image

      t.timestamps
    end
  end
end
