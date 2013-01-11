class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.integer :platform_id
      t.string :name

      t.timestamps
    end
  end
end
