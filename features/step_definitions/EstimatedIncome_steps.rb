Before do
  @suborganization1 = Organization.new
  @account = Account.new
  @sourceoffunds1 = SourceOfFunds.new
  @sourceoffunds2 = SourceOfFunds.new
end

Given /^I have a Source of Funds named "([^"]*)" with a likelihood of funding of (\d+)% and an amount of \$(\d+)$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

When /^I select Income Estimation$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the Income Estimation result should be \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end