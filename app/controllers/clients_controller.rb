class ClientsController < ApplicationController

  # Filters
  #########

  before_filter :get_record, :only => [:edit]

  # Actions
  #########

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def edit
  end
  
  def create
    @client = Client.new(params[:client])
    
    if @client.save
      redirect_to clients_path
    end
  end
  
  # Private methods
  #################
  
  private
  
  def get_record
    @client = Client.find(params[:id])
  end

end
