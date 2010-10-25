class Contract < ActiveRecord::Base
  
  # Assocations
  #############
  
  belongs_to :client

  has_many :invoice_lines
  has_many :invoices, :through => :invoice_lines
  
  # Scopes
  ########
  
  default_scope :order => "issued_on desc"
  
  # Instance methods
  ##################
  
  delegate :name, :to => :client, :prefix => true
  
  def amount_incl_vat
    amount_excl_vat * (1+vat)
  end
  
  def balance
    amount_incl_vat - invoice_lines.map(&:amount_incl_vat).sum
  end
  
end
