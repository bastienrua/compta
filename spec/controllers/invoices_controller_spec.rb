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
    
    let(:my_var) { "foo" }
    
    subject do
      get 'new'
      assigns
    end
    
    it "set @invoices with on invoice with number F11001" do
      subject["invoice"].number.should == "F11001"
    end
    
    context "when 1 invoice exists on the same year" do
      
      before { Factory(:invoice, :number => "F11001") }
      
      it "should set @invoices with number F11002" do
        subject["invoice"].number.should == "F11002"
      end
    end
    
    context "when 1 invoice exists on last year" do
      
      before {Factory(:invoice, :number => "F10218")}

        it "should set @invoices with number F11001" do
          subject["invoice"].number.should == "F11001"
        end

    end
    
  end
  
end