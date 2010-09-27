class MissingDbIndexInvoiceClientId < ActiveRecord::Migration
  def self.up
    add_index :invoices, :client_id
  end

  def self.down
    remove_index :invlices, :client_id
  end
end
