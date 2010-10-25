class CreateInvoiceLines < ActiveRecord::Migration
  def self.up
    create_table :invoice_lines do |t|
      t.integer :contract_id
      t.text :description
      t.decimal :amount_excl_vat
      t.integer :invoice_id
      t.timestamps
    end
    
    add_index :invoice_lines, :contract_id
    add_index :invoice_lines, :invoice_id
  end

  def self.down
    drop_table :invoice_lines
  end
end
