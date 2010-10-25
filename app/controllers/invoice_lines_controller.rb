class InvoiceLinesController < ApplicationController
  
  # Filters
  #########
  
  before_filter :get_invoice
  
  def new
    @invoice_line = @invoice.lines.build
  end

  def create
    
    @invoice_line = @invoice.lines.build(params[:invoice_line])
    if @invoice_line.save
      redirect_to edit_invoice_path(@invoice)
    else
      render :new
    end
    
  end

  def edit
    @invoice_line = InvoiceLine.find params[:id]
  end

  def update
    @invoice_line = InvoiceLine.find(params[:id])
    if @invoice_line.update_attributes(params[:invoice_line])
      redirect_to edit_invoice_path(@invoice)
    else
      render :edit
    end
  end
  
  # Private methods
  #################
  
  def get_invoice
    @invoice = Invoice.find params[:invoice_id]
  end
  
end