Before do
  @suborganization1 = Organization.new
  @account = Account.new
  @sourceoffunds1 = SourceOfFunds.new
  @sourceoffunds2 = SourceOfFunds.new
end
Given /^I have an organization with a total budget of \$(\d+)$/ do |arg1|
  @organization.budget = arg1.to_i
end

Given /^I have a Source of Funds named "([^"]*)"$/ do |arg1|
  @sourceoffunds1.name = arg1
end

Given /^that Source of Funds has a percentage of (\d+)%$/ do |arg1|
  @sourceoffunds1.percentage = arg1
end

Given /^I have another Source of Funds named "([^"]*)"$/ do |arg1|
  @sourceoffunds2.name = arg1
end

Given /^that other Source of Funds has a percentage of (\d+)%$/ do |arg1|
  @sourceoffunds2.percentage = arg1
end

When /^I select funding distribution$/ do
  @organization.addsof(@sourceoffunds1)
  @organization.addsof(@sourceoffunds2)
  @organization.fundingdistribution
end

Then /^the result should be \{"([^"]*)" => (\d+), "([^"]*)" => (\d+)\}$/ do |arg1, arg2, arg3, arg4|
    @organization.fundingdistribution[arg1].should ==  arg2.to_i 
    @organization.fundingdistribution[arg3].should ==  arg4.to_i 
end