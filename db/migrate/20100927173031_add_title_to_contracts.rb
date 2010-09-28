class AddTitleToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :title, :string
  end

  def self.down
    remove_column :contracts, :title
  end
end
