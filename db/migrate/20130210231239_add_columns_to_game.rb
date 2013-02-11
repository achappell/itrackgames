class AddColumnsToGame < ActiveRecord::Migration
  def change
    add_column :games, :release_date, :date
    add_column :games, :players, :string
    add_column :games, :publisher, :string
    add_column :games, :developer, :string
    add_column :games, :rating, :string
  end
end
