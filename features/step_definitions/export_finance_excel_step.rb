Before do
  @my_expenses = ExpenseBuilder.new
end

Given /^I have some expenses$/ do
  # try a step set up from the expense rules
  @my_expenses.mybills do
	    telephone 200	 
	    cell_phone 75
      rent 750
      car_note 350
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