module InvoicesHelper
  
  def sales(invoices)
    invoices.inject(0) do |sales, invoice|
      sales += invoice.amount_incl_vat
    end
  end
  
end
