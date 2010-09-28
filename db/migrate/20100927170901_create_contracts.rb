class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer :client_id
      t.decimal :amount_excl_vat
      t.decimal :vat
      t.date    :issued_on
      t.timestamps
    end
    
    add_index :contracts, :client_id
  end

  def self.down
    drop_table :contracts
  end
end
