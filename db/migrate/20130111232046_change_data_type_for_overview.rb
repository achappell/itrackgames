class ChangeDataTypeForOverview < ActiveRecord::Migration
  def up
  	change_table :platforms do |t|
  		t.change :overview, :text, :limit => nil
  	end
  end

  def down
  	change_table :platforms do |t|
  		t.change :overview, :string
  	end
  end
end
