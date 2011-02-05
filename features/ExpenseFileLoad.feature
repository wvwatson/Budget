@expense
Feature: Expense file load
  In order to load a bunch of expense rules easily
  As a projection user
  I want to load all of the expense rules from an expense file
  
  Scenario: load from expense_list.rb
    Given I have an expense file named "expense_list.rb"
    And I load the "expense_list.rb" expense file
    When I generate the projected expenses
    Then I should get a total of $30900 expenses for the year
