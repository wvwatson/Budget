Before do

  @expense_projection = ExpenseProjection.new
end

When /^I export the expenses to excel$/ do
  @expense_projection.expense_builder=@my
  @expense_projection.build_projection
  @expense_projection.export_excel
end

Then /^an excel spreadsheet should be created$/ do
  #debugger
  output_path = File.dirname(__FILE__) + "/../../lib/expenses.xls"
  File.exists?(output_path).should == true
end