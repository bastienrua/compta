class Contract < ActiveRecord::Base
  
  # Assocations
  #############
  
  belongs_to :client

  has_many :invoices
  
  # Scopes
  ########
  
  default_scope :order => :issued_on
  
  # Instance methods
  ##################
  
  delegate :name, :to => :client, :prefix => true
  
  def amount_incl_vat
    amount_excl_vat * (1+vat)
  end
  
end
