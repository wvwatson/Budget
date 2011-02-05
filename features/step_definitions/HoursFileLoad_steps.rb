Given /^I have an hours file named "([^"]*)"$/ do |arg1|
  output_path = File.dirname(__FILE__) + "/../../examples/" + arg1
  File.exists?(output_path).should == true
end

Given /^I load the "([^"]*)" hours file$/ do |arg1|
  input_path = File.dirname(__FILE__) + "/../../examples/" + arg1
  @Hours.load_hours input_path
end

When /^I generate the hourly tasks$/ do
  @Hours.total
end

Then /^the total hours collected should be (\d+)$/ do |arg1|
     @Hours.total.should == arg1.to_i
end

