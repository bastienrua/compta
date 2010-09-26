module InvoicesHelper
  
  def sales(invoices, incl_vat = true)
    sales = Invoice.sales(@invoices, incl_vat)
    suffix = incl_vat ? "TTC" : "HT"
    [number_to_currency(sales), suffix].join(' ')
  end
  
end
