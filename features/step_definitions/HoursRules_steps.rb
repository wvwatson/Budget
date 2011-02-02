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
      day_job 8.hours
  end
end

Then /^the total hours for the day should be (\d+)$/ do |arg1|
   @Hours.total.should == arg1.to_i
end