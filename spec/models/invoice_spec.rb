require 'spec_helper'

describe Invoice do
  
  subject {FactoryGirl.build(:invoice)}
  
  its(:number) { should == "F11001" }
  
  context "when one invoice was created last year" do
    before { FactoryGirl.create(:invoice, :number => "F10001") }
  
    its(:number) { should == "F11001" }
  end
  
  context "when 2 invoices exist for the same year" do
    
    before do
      
      ["F11001", "F11002"].each do |e|
        FactoryGirl.create(:invoice, :number => e)
      end
      
    end
    
    its(:number) { should == "F11003" }
  
  end
  
  describe "invoiced_on" do
    it "should be present" do
      Invoice.new.should have(1).error_on(:invoiced_on)
    end
  end
  
end