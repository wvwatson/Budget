Before do
  @workplan = WorkPlan.new
  @goals = []
  @actions = []
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
  #pending # express the regexp above with the code you wish you had
    @goals = @workplan.show_workplan
    @goals.each do | goal | 
	  # puts "goal desc = " + goal.description
	  # puts "arg2 = " + arg2
      (goal.addactions arg1) if goal.description == arg2
	  #@actions = goal.show_actions
	  #puts @actions.count.to_s
	  #@actions.each { |action| puts action.description }
    end
end

Given /^I have entered "([^"]*)" and assigned it to the "([^"]*)" goal as the second action$/ do |arg1, arg2|
  #pending # express the regexp above with the code you wish you had
  @goals = @workplan.show_workplan
   @goals.each do | goal | 
     goal.addactions arg1 if goal.description == arg2
   end
end

When /^I display the "([^"]*)" goal$/ do |arg1| 
  #pending # express the regexp above with the code you wish you had
   @goals = @workplan.show_workplan
   @goals.each do | goal | 
         @actions = goal.show_actions
		 @actions.each { |action| puts action.description } if goal.description = arg1
      end
end

Then /^the result should be "([^"]*)" and "([^"]*)" on the screen for the "([^"]*)" goal$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end


