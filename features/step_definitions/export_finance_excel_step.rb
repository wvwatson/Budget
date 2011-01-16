Before do
  @my_expenses = ExpenseBuilder.new
end

Given /^I have income and expenses calculated for (\d+) year$/ do |arg1|
  pending # express the regexp above with the code you wish you had
  #@my.export_excel
end

When /^I export the income statement to excel$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have some expenses$/ do
  @my_expenses.mybills do
	    telephone 200	 
  end
end

When /^I export the expenses to excel$/ do
  @my_expenses.export_excel
end

Then /^an excel spreadsheet should be created$/ do
  #debugger
  output_path = File.dirname(__FILE__) + "/../../lib/expenses.xls"
  File.exists?(output_path).should == true
end