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
