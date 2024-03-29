class ContractsController < ApplicationController
  
  # Filters
  #########
  
  before_filter :get_record, :only => [:edit, :update]
  
  # Actions
  #########
  
  def index
    @contracts = Contract.includes(:client, :invoice_lines => :invoice)
    @contracts = @contracts & Client.where(:id => params[:client_id]) if params[:client_id]
    @contracts = @contracts.find_all {|contract| contract.balance <= 0} if params[:complete]
    @contracts = @contracts.find_all {|contract| contract.balance > 0} if params[:incomplete]
  end

  def new
    @contract = Contract.new
  end

  def edit
  end

  def create
    @contract = Contract.new params[:contract]
    
    if @contract.save
      redirect_to contracts_path
    end
  end

  def update
    if @contract.update_attributes(params[:contract])
      redirect_to contracts_path
    end
  end
  
  # Private methods
  #################
  
  private
  
  def get_record
    @contract = Contract.find(params[:id])
  end

end
