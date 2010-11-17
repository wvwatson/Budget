Before do
  @expenditure = Expenditure.new
  @suborganization1 = Organization.new
  @account = Account.new
end
Given /^I have an expenditure with \$(\d+)$/ do |arg1|
  @expenditure.dollars = arg1
end

Given /^the expenditure has a budget object named "([^"]*)"$/ do |arg1|
  @expenditure.BudgetObject.name = arg1
end

Given /^I have an account named "([^"]*)"$/ do |arg1|
  @account.name = arg1
end

Given /^the account has \$(\d+)$/ do |arg1|
  @account.dollars = arg1
end

When /^I press account add$/ do
  @account.add(@expenditure)
end

Then /^the account dollars should be \$(\d+)$/ do |arg1|
  @account.dollars.should equal( arg1.to_i )
end