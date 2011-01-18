Feature: Export Financial Statement 
  In order to review a financial statement
  As a reviewer of budgets
  I want to export a financial statement to excel 

  Scenario: Export some expenses to excel
    Given I have expense rules set up
    When I export the expenses to excel
    Then an excel spreadsheet should be created

