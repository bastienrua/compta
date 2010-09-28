require "csv"

class Invoice < ActiveRecord::Base
  
  # Assocations
  #############
  
  belongs_to :client
  belongs_to :contract

  # Scopes
  ########
  
  default_scope :order => :number

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
    invoices.inject(0) do |sales, invoice|
      sales += incl_vat ? invoice.amount_incl_vat : invoice.amount_excl_vat
    end
  end
  
  # Instance methods
  ##################
  
  delegate :name, :to => :client, :prefix => true
  
  def amount_incl_vat
    amount_excl_vat * (1+vat)
  end
  
end
