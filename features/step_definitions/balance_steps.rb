require 'ruby-debug'
Before do
  @expenditure = Expenditure.new
  @account = Account.new
  @organization = Organization.new
  @sourceoffunds1 = SourceOfFunds.new
  @sourceoffunds2 = SourceOfFunds.new
end

Given /^I have an assigned source of funds with \$(\d+)$/ do |arg1|
    @source_of_funds = SourceOfFunds.new
    @source_of_funds.dollars = arg1
    @source_of_funds.likelyhood = 100
    @organization.addsof(@source_of_funds)
end

Given /^the total of an organization's expenditures is \$(\d+)$/ do |arg1|
  @expenditure.dollars = arg1.to_i
  @account.add(@expenditure)
  @organization.addaccount(@account)
end

When /^I check the balance$/ do
  @organization.balance
end


Then /^the balance should be \$"([^"]*)"$/ do |arg1|
  @organization.balance.should == arg1.to_i
end


Then /^the balance for the "([^"]*)" SOFs should be \$"([^"]*)"$/ do |arg1, arg2|
  #debugger
  @organization.balance(arg1).should == arg2.to_i
end

