class InvoicesController < ApplicationController
  
  # Filters
  #########
  
  before_filter :get_record, :only => [:update]
  
  # Actions
  #########
  
  def index
    @invoices = Invoice.includes(:client, :lines)
    @invoices = @invoices & Client.where(:id => params[:client_id]) if params[:client_id]
    @invoices = @invoices & InvoiceLine.where(:contract_id => params[:contract_id]) if params[:contract_id]
    @invoices = @invoices.where(:invoiced_on => (Date.parse(params[:from])..Date.parse(params[:to]))) if params[:from]
  end
  
  def new
    @invoice = Invoice.new
    
    current_year_2_digits = Date.current.year.to_s[2,3]
    last_invoice = Invoice.last
    
    number_if_first_in_year = "F" + current_year_2_digits + "001"
    
    @invoice.number = unless Invoice.count.zero?
      
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
  
  def edit
    @invoice = Invoice.where(:id => params[:id]).includes(:lines => :contract).first
  end
  
  def create
    @invoice = Invoice.new(params[:invoice])
    if @invoice.save
      redirect_to invoices_path
    end
  end
  
  def update
    if @invoice.update_attributes(params[:invoice])
      redirect_to invoices_path
    end
  end
  
  # Private methods
  #################
  
  private
  
  def get_record
    @invoice = Invoice.find(params[:id])
  end
  
end
