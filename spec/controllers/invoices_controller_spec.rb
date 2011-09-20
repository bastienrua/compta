require 'spec_helper'

describe InvoicesController do
  
  describe "GET index" do
    it "should set @invoices" do
      i = Invoice.create! :invoiced_on => Date.today
      get 'index'
      assigns["invoices"].should == [i]
    end
  end
  
  describe "GET new" do
    
    it "set @invoices with on invoice with number F11001" do
      get 'new'
      assigns["invoice"].number.should == "F11001"
    end
    
    it "should set @invoices with number F11002" do
      i = Invoice.create! :invoiced_on => Date.today, :number => "F11001"
      get 'new'
      assigns["invoice"].number.should == "F11002"
    end
    
    it "should set @invoices with number F11001" do
      i = Invoice.create! :invoiced_on => Date.today.prev_year, :number => "F10218"
      get 'new'
      assigns["invoice"].number.should == "F11001"
    end
  end
  
end