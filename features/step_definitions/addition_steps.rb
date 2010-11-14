Before do
  @calculator = Calculator.new
end

Given /^I have entered ([0-9]*) into the calculator$/ do |value|
  @calculator.enter( value.to_i )
end

When /^I press add$/ do
  @calculator.add
end

Then /^the result should be ([0-9]*) on the screen$/ do |value|
  @calculator.screen.should equal( value.to_i )
end
