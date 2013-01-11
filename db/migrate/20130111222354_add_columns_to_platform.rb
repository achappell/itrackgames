class AddColumnsToPlatform < ActiveRecord::Migration
  def change
    add_column :platforms, :overview, :string
    add_column :platforms, :developer, :string
  end
end
