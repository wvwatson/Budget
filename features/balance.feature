 Feature: Balance
  In order to check the balance
  As a submitter of budgets
  I want to subtract the total amount of source of funds available from the total proposed proposed budget

  Scenario: Check that the balance is positive
    Given I have an assigned source of funds with $800
	And I have an assigned source of funds with $200
	And the total of an organization's expenditures is $500
    When I check the balance
    Then the balance should be $500

  Scenario: Check that the balance is negative
    Given I have an assigned source of funds with $800
	And I have an assigned source of funds with $200
	And the total of an organization's expenditures is $2000
    When I check the balance
    Then the balance should be -$1000

  Scenario: Check that only proper SOFS are counted
    Given I have an assigned source of funds with $800
	And I have an unassigned source of funds with $200
	And the total of an organization's expenditures is $500
    When I check the balance
    Then the balance should be $300