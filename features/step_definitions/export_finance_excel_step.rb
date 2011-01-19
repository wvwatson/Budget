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

Then /^the excel spreadsheet should have (\d+) columns filled$/ do |arg1|
  #pending # express the regexp above with the code you wish you had
  output_path = File.dirname(__FILE__) + "/../../lib/expenses.xls"
  #debugger
  (1..arg1.to_i).each do |month_count|
       # puts month_count
       #        puts Spreadsheet.open(output_path).worksheets.first.row(1)[month_count]
       #        puts Date::MONTHNAMES.include?(Spreadsheet.open(output_path).worksheets.first.row(1)[month_count])
       #        puts  Spreadsheet.open(output_path).worksheets.first.row(1)[month_count].nil? 
       # checking for nil is wierd, 'and' is wierd -- need parens
        (Date::MONTHNAMES.include?(Spreadsheet.open(output_path).worksheets.first.row(1)[month_count]) and
          Spreadsheet.open(output_path).worksheets.first.row(1)[month_count].nil? == false).should == true


  end
end
