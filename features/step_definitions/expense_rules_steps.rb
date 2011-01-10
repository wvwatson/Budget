Before do
  @my = ExpenseBuilder.new
end

Given /^I have a monthly expense of telephone that is \$(\d+)$/ do |arg1|
   #pending # express the regexp above with the code you wish you had
   # try instance eval
  @my.mybills do
	    telephone arg1	 
  end
end

Given /^I have a monthly expense of cell_phone that is \$(\d+)$/ do |arg1|
  @my.mybills do
	    cell_phone arg1	 
  end
end

Given /^I have a monthly expense of rent that is \$(\d+)$/ do |arg1|
  @my.mybills do
	    rent arg1	 
  end
end

Given /^I have a monthly expense of car_note that is \$(\d+)$/ do |arg1|
  @my.mybills do
	    car_note arg1	 
  end
end


When /^I ask for my total monthly expenses$/ do
  @my.total
end

Then /^total of the monthly expenses should be \$(\d+)$/ do |arg1|
  @my.total.should == arg1.to_i
end

Given /^I have a one time birthday expense of \$"([^"]*)" on "([^"]*)"$/ do |arg1, arg2|
  # pending # express the regexp above with the code you wish you had
  @my.on arg2 do
       birthday arg1
    end
end

Then /^the total of the one time expenses should be \$(\d+)$/ do |arg1|
    @my.total.should == arg1.to_i
end

Given /^I have an incremental car_insurance expense of \$"([^"]*)" every (\d+) months$/ do |arg1, arg2|
  @my.every arg2.to_i.months do
 	  car_insurance arg1
   end
end

Then /^the total of the incremental expenses should be \$(\d+)$/ do |arg1|
    @my.total.should == arg1.to_i
end

Given /^I have a monthly ranged lawn care expense of \$"([^"]*)" from "([^"]*)" to "([^"]*)"$/ do |arg1, arg2, arg3|
  @my.from arg2, arg3 do
    every :month do
      lawn_care arg1
    end
  end
end

Then /^the total of the ranged expenses should be \$(\d+)$/ do |arg1|
  @my.total.should == arg1.to_i
end


