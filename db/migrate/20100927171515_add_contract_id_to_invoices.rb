class AddContractIdToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :contract_id, :integer
    add_index :invoices, :contract_id
  end

  def self.down
    remove_column :invoices, :contract_id
  end
end
