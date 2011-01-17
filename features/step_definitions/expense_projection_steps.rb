Before do
  @expense_projection = ExpenseProjection.new
end

Given /I have expense rules set up/ do
  steps %Q{
    Given I have a monthly expense of telephone that is $50
    And I have a monthly expense of cell_phone that is $75
    And I have a monthly expense of rent that is $750
    And I have a monthly expense of car_note that is $350
    Given I have a one time birthday expense of $"250" on "8/3/2011"
    Given I have an incremental car_insurance expense of $"600" every 6 months
    Given I have a monthly ranged lawn care expense of $"250" from "3/1/2011" to "11/1/2011"
    Given I have a car maintenance expense of $"500" with a chance of 25%
    And I have a tax expense of $"5000" on "4/15/2011" I want to file an extension if my total expenses are more than "10000"
  }
end

When /^I generate the projected expenses$/ do
  #debugger
  pending # express the regexp above with the code you wish you had
end

Then /^I should get (\d+) expenses with labels for each month$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
