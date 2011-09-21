require "csv"

class Invoice < ActiveRecord::Base
  
  validates :invoiced_on, :presence => true
  
  after_initialize do
    if !persisted?
      current_year_2_digits = Date.current.year.to_s[2,3]
      last_invoice = Invoice.first
      
      number_if_first_in_year = "F" + current_year_2_digits + "001"
      
      self.number = unless Invoice.count.zero?
        
        # if there is at least one invoices in the DB
        if last_invoice.number[1,2] == current_year_2_digits
          
          # if last invoice was numbered this year
          last_invoice.number.next
        else
          # if last invoice was numbered last year
          number_if_first_in_year
        end
      else
        # if there is are no invoices in the DB
        number_if_first_in_year
      end

    end
  end


  # Assocations
  #############
  
  belongs_to :client
  
  has_many :lines, :class_name => "InvoiceLine"
  has_many :contracts, :through => :lines

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
