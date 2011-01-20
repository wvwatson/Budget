@expense
Feature: Export Financial Statement 
  In order to review a financial statement
  As a reviewer of budgets
  I want to export a financial statement to excel 

  Scenario: Export some expenses to excel
    Given I have expense rules set up
    When I export the expenses to excel
    Then an excel spreadsheet should be created

  Scenario: Export 12 months of expenses to excel
    Given I have expense rules set up
    When I export the expenses to excel
    Then the excel spreadsheet should have 12 columns filled
