Before do
  @my = Expenses.new
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
  pending # express the regexp above with the code you wish you had
end

Then /^total of the monthly expenses should be \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end