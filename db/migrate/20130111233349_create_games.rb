class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :platform
      t.text :overview, :limit => nil
      t.string :esrb
      t.references :platform

      t.timestamps
    end

    add_index :games, :platform_id
  end
end
