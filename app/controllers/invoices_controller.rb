class InvoicesController < ApplicationController
  
  # Filters
  #########
  
  before_filter :get_record, :only => [:edit, :update]
  
  # Actions
  #########
  
  def index
    @client = Client.find_by_id params[:client_id]
    @contract = Contract.find_by_id params[:contract_id]
    
    scope = if @client
      @client.invoices
    elsif @contract
      @contract.invoices
    else
      Invoice
    end
    
    scope = scope.where(:invoiced_on => (Date.parse(params[:from])..Date.parse(params[:to]))) if params[:from]
    @invoices = scope.includes(:client, :contract)
  end
  
  def new
    @invoice = Invoice.new
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
