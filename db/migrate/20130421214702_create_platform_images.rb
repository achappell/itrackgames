class CreatePlatformImages < ActiveRecord::Migration
  def change
    create_table :platform_images do |t|
      t.references :platform
      t.references :image

      t.timestamps
    end
    add_index :platform_images, :platform_id
    add_index :platform_images, :image_id
  end
end
