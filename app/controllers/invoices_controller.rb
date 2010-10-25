class InvoicesController < ApplicationController
  
  # Filters
  #########
  
  before_filter :get_record, :only => [:edit, :update]
  
  # Actions
  #########
  
  def index
    @invoices = Invoice.includes(:client)
    @invoices = @invoices & Client.where(:id => params[:client_id]) if params[:client_id]
    @invoices = @invoices.where(:invoiced_on => (Date.parse(params[:from])..Date.parse(params[:to]))) if params[:from]
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
