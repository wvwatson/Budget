my = Expenses.new
Given /^I have a monthly expense of "([^"]*)" that is \$(\d+)$/ do |arg1, arg2|
  my.bills do
	 #puts self.class
	 #telephone $50 
  end
end

When /^I ask for my total monthly expenses$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^total of the monthly expenses should be \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end