Before do
  @workplan = WorkPlan.new
  @goals = []

end

Given /^I have entered "([^"]*)" as the first goal$/ do |arg1|
  @workplan.addgoals arg1
end

Given /^I have entered "([^"]*)" as the second goal$/ do |arg1|
  @workplan.addgoals arg1
end

When /^I press show workplan$/ do
  @goals = @workplan.show_workplan
end

Then /^the result should be "([^"]*)" and "([^"]*)" on the screen$/ do |arg1, arg2|
  @goals[0].description.should ==  arg1
  @goals[1].description.should ==  arg2
end

Given /^I have entered "([^"]*)" and assigned it to the "([^"]*)" goal as the first action$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^I have entered "([^"]*)" and assigned it to the "([^"]*)" goal as the second action$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I display the "([^"]*)" goal$/ do |arg1| 
  pending # express the regexp above with the code you wish you had
end

Then /^the result should be "([^"]*)" and "([^"]*)" on the screen for the "([^"]*)" goal$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end


