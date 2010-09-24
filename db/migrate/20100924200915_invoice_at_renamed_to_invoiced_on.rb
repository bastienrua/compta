class InvoiceAtRenamedToInvoicedOn < ActiveRecord::Migration
  def self.up
    rename_column :invoices, :invoiced_at, :invoiced_on
  end

  def self.down
    rename_column :invoices, :invoiced_on, :invoiced_at
  end
end
