class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string    :number
      t.decimal   :amount_excl_vat
      t.decimal   :vat
      t.integer   :client_id
      t.date      :invoiced_at
      t.string    :state

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
