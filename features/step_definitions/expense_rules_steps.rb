Before do
  @my = ExpenseBuilder.new
  @my.start_date = Date.strptime('2/1/2011', '%m/%d/%Y')
  @my.end_date = @my.start_date + 11.months # 1 year default
  
  @my_revenue = RevenueBuilder.new
  @my_budget = BudgetBuilder.new
  @my_budget.expense_builder = @my
  @my_budget.revenue_builder = @my_revenue
end

Given /^I have a monthly expense of telephone that is \$(\d+)$/ do |arg1|
   #pending # express the regexp above with the code you wish you had
   # try instance eval
  @my.add do
	    telephone arg1	 
  end
end

Given /^I have a monthly expense of cell_phone that is \$(\d+)$/ do |arg1|
  @my.add do
	    cell_phone arg1	 
  end
end

Given /^I have a monthly expense of rent that is \$(\d+)$/ do |arg1|
  @my.add do
	    rent arg1	 
  end
end

Given /^I have a monthly expense of car_note that is \$(\d+)$/ do |arg1|
  @my.add do
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
  # ranged can be incremental too ... need a way to do both
  # ranged is incremental (usually 1 month increments).  Probably need to default to 1 month
  @my.from arg2, arg3 do
    every :month do
      lawn_care arg1
    end
  end
end

Then /^the total of the ranged expenses should be \$(\d+)$/ do |arg1|
  @my.total.should == arg1.to_i
end

Given /^I have a car maintenance expense of \$"([^"]*)" with a chance of (\d+)%$/ do |arg1, arg2|
  @my.add do
    car_maintenance do
      cost arg1
      chance arg2
    end
  end
end

Then /^the total of the car maintenance should be \$(\d+)$/ do |arg1|
  @my.total.should == arg1.to_i
end

# Given /^I have "([^"]*)"$/ do |arg1|
#   @my_revenue.add do
#       income arg1  
#   end
# end

Given /^I have "([^"]*)" of other expenses$/ do |arg1|
  @my.add do
	    total_expenses arg1	 
  end
end

Given /^I have a tax expense of \$"([^"]*)" on "([^"]*)" I want to file an extension if my total expenses are more than "([^"]*)"$/ do |arg1, arg2, arg3|
  # make this an income statement (which includes expenses and income) test and replace it with an
  # expense - only test. maybe make it so that income/cashflow statement rules get applied after individual
  # revenue or expense rules
    @my.on arg2 do
      #debugger
  	  taxes arg1 do
  	  # whatever code you want in here
  	  # needs to make sense within context of builder
  	  # how do I make the expense aware of the income?
  	  # separate expense specific code from income_statement specific code (which
  	  #  includes expenses and income ... and has references to both)
  	  #debugger
      if total.to_f > arg3.to_f
        #file_extension
        #why doesn't an = work here?
        cost 0
        #date = date.3.months.from_now
      end
  	end
  end
end

Then /^the total expenses at "([^"]*)" should be \$(\d+)$/ do |arg1, arg2|
    @my.total.should == arg2.to_i
end



