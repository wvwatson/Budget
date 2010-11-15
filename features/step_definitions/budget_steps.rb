Before do
  @organization = Organization.new
  @suborganization = Organization.new
  @organization.addsub(@suborganization)
end
Given /^I have an organization with \$(\d+)$/ do |arg1|
  @organization.account( arg1.to_i )
end

Given /^I have a sub organization with \$(\d+)$/ do |arg1|
   @suborganization.account( arg1.to_i )
end

When /^I select roll up$/ do
  @organization.rollup
end

Then /^the result should be \$(\d+)$/ do |arg1|
  @organization.budget.should equal( arg1.to_i )
end
