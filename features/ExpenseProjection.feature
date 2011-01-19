@expense
Feature: Create an expense projection
  In order to review an expense projection for a protracted period of time
  As a reviewer of budgets
  I want to generate monthly expenses based on expense rules 

  Scenario: Generate expenses for one year
    Given I have expense rules set up
    When I generate the projected expenses
    Then I should get 12 expenses with labels for each month

  Scenario: Total for one month
    Given I have expense rules set up
    When I generate the projected expenses
    Then I should get a total of $16200 of monthly expenses for the year