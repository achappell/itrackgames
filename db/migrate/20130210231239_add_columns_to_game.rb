class AddColumnsToGame < ActiveRecord::Migration
  def change
    add_column :games, :ReleaseDate, :date
    add_column :games, :Players, :string
    add_column :games, :Publisher, :string
    add_column :games, :Developer, :string
    add_column :games, :Rating, :string
  end
end
