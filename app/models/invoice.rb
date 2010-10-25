require "csv"

class Invoice < ActiveRecord::Base
  
  # Assocations
  #############
  
  belongs_to :client
  belongs_to :contract
  
  has_many :lines, :class_name => "InvoiceLine"

  # Scopes
  ########
  
  default_scope :order => "number DESC"

  def self.import(path)
    arrays = CSV.read(path)
    arrays[1..-1].each do |ary|
      row = CSV::Row.new(arrays.first, ary)
      Invoice.new(row.to_hash).save
    end
    
  end
  
  # Class methods
  ###############
  
  def self.sales(invoices, incl_vat = true)
    method = incl_vat ? :amount_incl_vat : :amount_excl_vat
    invoices.map(&method).sum
  end
  
  # Instance methods
  ##################
  
  delegate :name, :to => :client, :prefix => true
  delegate :title, :to => :contract, :prefix => true, :allow_nil => true
  
  def amount_excl_vat
    lines.map(&:amount_excl_vat).sum
  end

  def amount_incl_vat
    amount_excl_vat * (1+vat)
  end
  
end
