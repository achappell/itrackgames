class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :GameTitle
      t.string :Platform
      t.text :Overview, :limit => nil
      t.string :ESRB
      t.references :platform

      t.timestamps
    end

    add_index :games, :platform_id
  end
end
