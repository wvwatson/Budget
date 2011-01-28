@expense
Feature: Export Financial Statement to mongodb 
  In order to review a financial statement
  As a reviewer of budgets
  I want to export a financial statement to mongodb 

  Scenario: Export some expenses to mongodb
    Given I have expense rules set up
    When I export the expenses to mongodb
    Then a mongo database should be created

  Scenario: Export 12 months of expenses to mongodb
    Given I have expense rules set up
    When I export the expenses to mongodb
    Then the mongodb database should have 12 columns filled