require 'ruby-debug'

Given /^the "([^"]*)" fund is tagged as "([^"]*)"$/ do |arg1, arg2|
  #debugger
  @organization.addsoftag(arg1,arg2)
end

Then /^the "([^"]*)" funds available should be \$(\d+)$/ do |arg1, arg2|
  #debugger
  @organization.income_estimation(arg1).should == arg2.to_i
end

