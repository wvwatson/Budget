Before do
  @Hours = HoursBuilder.new
  @Hours.start_date = Date.strptime('2/1/2011', '%m/%d/%Y')
  @Hours.end_date = @Hours.start_date + 11.months # 1 year default
end

Given /^I work on a family web site "([^"]*)" hour a day$/ do |arg1|
  @Hours.add do
	    family_web_site arg1	 
  end
end

Given /^I work on at a day job "([^"]*)" hours a day$/ do |arg1|
  @Hours.add do
	  #debugger
      day_job 8.hours
  end
end

Then /^the total hours for the day should be (\d+)$/ do |arg1|
   @Hours.total.should == arg1.to_i
end

Given /^I have a task named meeting for "([^"]*)" hour at "([^"]*)" every monday$/ do |arg1, arg2|
  #pending # express the regexp above with the code you wish you had
  #debugger
  @Hours.every :monday do
    meeting arg1, :at => arg2
  end
end

Given /^I have a one time medical checkup for "([^"]*)" hours on "([^"]*)"$/ do |arg1, arg2|
  @Hours.on arg2 do
      medical_checkup arg1
  end
end

Given /^I have a one time medical checkup for "([^"]*)" hours on "([^"]*)" on one line$/ do |arg1, arg2|
  @Hours.add do
    medical_checkup arg1, :date => arg2
  end
end

Given /^I have some tasks set up$/ do
  steps %Q{
    Given I work on a family web site "1" hour a day
    And I work on at a day job "8" hours a day
  }
end

Given /^I replace all of the day's hours as a sick day$/ do
  #debugger
  @Hours.add do
    replace :all, :sick_day
  end
end

Then /^the total hours for the day should be (\d+) and the tasks should be assigned to sick day$/ do |arg1|
   #debugger
   @Hours.total.should == arg1.to_i and 
   @Hours.hours_list.each {|rule| break true if rule.name == "sick_day"}.should == true
end

Given /^I have a side project meeting lasting "([^"]*)" hour from "([^"]*)" to "([^"]*)" every monday at "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
  # range
  @Hours.from arg2, arg3 do
    every :month do
      side_project_meeting arg1, {:every => :monday, :at => arg4}
    end
  end
end