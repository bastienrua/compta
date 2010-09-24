class Client < ActiveRecord::Base
  
  # Assocations
  #############
  
  has_many :invoices

  # Scopes
  ########
  
  default_scope :order => :name
  
end
