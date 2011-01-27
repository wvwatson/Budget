Before do
  @income = IncomeBuilder.new
end

Given /^I have a monthly income stream of day_job that is \$(\d+)$/ do |arg1|
  #pending # express the regexp above with the code you wish you had
  @income.add do
	    day_job arg1	 
  end
end

Given /^I have a monthly income stream of rental_property that is \$(\d+)$/ do |arg1|
  #pending # express the regexp above with the code you wish you had
  @income.add do
	    rental_property arg1	 
  end
end

Then /^total of the monthly income should be \$(\d+)$/ do |arg1|
  #pending # express the regexp above with the code you wish you had
  @income.total.should == arg1.to_i
end
