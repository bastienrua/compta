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
    if !Invoice.all.empty?
      if Invoice.last.number[1,2] == Date.current.year.to_s[2,3]
        number = Invoice.last.number.gsub("F#{Date.current.year.to_s[2,3]}", "").to_i
        number += 1
        
        last_number = case number
        when (0...10)
          last_number = "00#{number}"
        when (10...100)
          last_number = "0#{number}"
        else
          number.to_s
        end
        
        @invoice.number = "F" + Date.current.year.to_s[2,3] + last_number
      else
        @invoice.number = "F" + Date.current.year.to_s[2,3] + "001"
      end
    else
      @invoice.number = "F" + Date.current.year.to_s[2,3] + "001"
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
