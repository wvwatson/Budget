Feature: Export Financial Statement 
  In order to review a financial statement
  As a reviewer of budgets
  I want to export a financial statement to excel 

  Scenario: Export an income statement to excel
    Given I have income and expenses calculated for 1 year
    When I export the income statement to excel
    Then an excel spreadsheet should be created