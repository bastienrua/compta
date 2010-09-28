class Client < ActiveRecord::Base
  
  # Assocations
  #############
  
  has_many :invoices
  has_many :contracts

  # Scopes
  ########
  
  default_scope :order => :name
  
end
