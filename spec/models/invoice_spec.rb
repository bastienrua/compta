require 'spec_helper'

describe Invoice do
  it "should fail to save invoice without date" do
    a = Invoice.new
    a.should have(1).error_on(:invoiced_on)
  end
end