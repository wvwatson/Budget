Before do
  @expenditure = Expenditure.new
  @account = Account.new
  @organization = Organization.new
end

Given /^I have an organization's expenditure tagged as "([^"]*)"$/ do |arg1|
  @expenditure.addtags arg1
end

Given /^the organization's expenditure has \$(\d+)$/ do |arg1|
  @expenditure.dollars = arg1.to_i
end

Given /^an organization's account named "([^"]*)"$/ do |arg1|
  @account.addtags(arg1)
end

When /^I roll indirect expenditures up$/ do
  @account.add(@expenditure)
  @organization.addaccount(@account)
  @organization.rollup
end

Then /^the indirect account should be \$(\d+)$/ do |arg1|
  @organization.accounts.each do |indirect|
    if indirect.name="indirect"
       indirect.dollars.should ==  arg1.to_i 
    else 
       false
    end 
  end
end

