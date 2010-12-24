
Before do
  @organization = Organization.new
end

Given /^I have a Source of Funds named "([^"]*)" with a likelihood of funding of (\d+)% and an amount of \$(\d+)$/ do |arg1, arg2, arg3|
  @sourceoffunds = SourceOfFunds.new
  @sourceoffunds.name = arg1
  @sourceoffunds.likelyhood = arg2
  @sourceoffunds.dollars = arg3
  @organization.addsof(@sourceoffunds)
end

Then /^the Income Estimation should be \$(\d+)$/ do |arg1|
  @organization.income_estimation.should == arg1.to_i
end

