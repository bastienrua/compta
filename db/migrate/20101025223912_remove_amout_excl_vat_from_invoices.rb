class RemoveAmoutExclVatFromInvoices < ActiveRecord::Migration
  def self.up
    
    Invoice.all.each do |invoice|
      invoice.lines.create(
        :amount_excl_vat => invoice.amount_excl_vat,
        :contract_id => invoice.contract_id
      )
    end
    
    remove_column :invoices, :amount_excl_vat
    remove_column :invoices, :contract_id
  end

  def self.down
    add_column  :invoices, :amount_excl_vat, :decimal
    add_column  :invoices, :contract_id, :integer
    add_index   :invoices, :contract_id
    
    InvoiceLine.all.each do |line|
      line.invoice.update_attributes(
        :contract_id => line.contract_id,
        :amount_excl_vat => line.amount_excl_vat
      )
    end
    
    InvoiceLine.destroy_all
  end
end
