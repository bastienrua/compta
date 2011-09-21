FactoryGirl.define do

  factory :invoice do
    invoiced_on { Date.today }
  end


end