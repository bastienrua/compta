require "csv"

class Invoice < ActiveRecord::Base
  
  # Assocations
  #############
  
  belongs_to :client

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
  
  # Instance methods
  ##################
  
  def amount_incl_vat
    amount_excl_vat * (1+vat)
  end
  
end