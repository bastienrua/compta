require 'spec_helper'

describe Invoice do
  it "should fail to save invoice without date" do
    a = Invoice.new
    a.should have(1).error_on(:invoiced_on)
  end
  
  it "should have a invoice number = F11001 (first invoice of the year)" do
    a = Invoice.new
    a.number = "F10001"
    a.invoiced_on = Date.today.prev_year
    a.save
    
    f = Invoice.new
    f.number.should == "F11001"
  end
  
  it "should have a invoice number = F11003 (third invoice of the year)" do
    a = Invoice.new
    a.number = "F11001"
    a.invoiced_on = Date.today.prev_year
    a.save
    b = Invoice.new
    b.number = "F11002"
    b.invoiced_on = Date.today.prev_year
    b.save
    
    f = Invoice.new
    f.number.should == "F11003"
  end
  let(:number) {"F#{Date.today.year.to_s[2,3]}001"}
  it "should create an invoice with number = F#{Date.today.year.to_s[2,3]}001 (empty invoices table)" do
    f = Invoice.new
    f.number.should == "F#{Date.today.year.to_s[2,3]}001"
  end

end