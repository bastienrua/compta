class InvoiceLine < ActiveRecord::Base
  
  # Assocations
  #############
  
  belongs_to :contract
  belongs_to :invoice
  
  # Instance methods
  ##################
  
  def amount_incl_vat
    amount_excl_vat * (1+invoice.vat)
  end
  
end
