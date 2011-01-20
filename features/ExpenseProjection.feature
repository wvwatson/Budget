@expense
Feature: Create an expense projection
  In order to review an expense projection for a protracted period of time
  As a reviewer of budgets
  I want to generate monthly expenses based on expense rules 

  Scenario: Generate expenses for one year
    Given I have expense rules set up
    When I generate the projected expenses
    Then I should get 12 expenses with labels for each month

  Scenario: Total monthly expenses for the year
    Given I have expense rules set up
    When I generate the projected expenses
    Then I should get a total of $20700 of monthly expenses for the year

  Scenario: Total one time expenses for the year
    Given I have expense rules set up
    When I generate the projected expenses
    Then I should get a total of $16200 of one time expenses for the year

  Scenario: Total ranged expenses for the year
    Given I have expense rules set up
    When I generate the projected expenses
    Then I should get a total of $16200 ranged expenses for the year

  Scenario: Total expenses for the year
    Given I have expense rules set up
    When I generate the projected expenses
    Then I should get a total of $16200 expenses for the year