Before do
  @organization = Organization.new
  @suborganization1 = Organization.new
  @suborganization2 = Organization.new

end
Given /^I have an organization with \$(\d+)$/ do |arg1|
  @organization.Account.dollars=arg1.to_i
end

Given /^I have a sub organization1 with \$(\d+)$/ do |arg1|
   @suborganization1.Account.dollars=arg1.to_i
end

Given /^I have a sub organization2 with \$(\d+)$/ do |arg1|
   @suborganization2.Account.dollars=arg1.to_i
end

When /^I select roll up$/ do
  @organization.addsub(@suborganization1)
  @organization.addsub(@suborganization2)
  @organization.rollup
end

Then /^the result should be \$(\d+)$/ do |arg1|
  @organization.budget.should == arg1.to_i 
end
