class InvoiceLine < ActiveRecord::Base
  
  # Assocations
  #############
  
  belongs_to :contract
  belongs_to :invoice
  
end
