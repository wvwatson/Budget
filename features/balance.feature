 Feature: Balance
  In order to check the balance
  As a submitter of budgets
  I want to subtract the total amount of source of funds available from the total proposed proposed budget

  Scenario: Check that the balance is positive
    Given I have an assigned source of funds with $800
	And I have an assigned source of funds with $200
	And the total of an organization's expenditures is $500
    When I check the balance
    Then the balance should be $"500"

  Scenario: Check that the balance is negative
    Given I have an assigned source of funds with $800
	And I have an assigned source of funds with $200
	And the total of an organization's expenditures is $2000
    When I check the balance
    Then the balance should be $"-1000"

  Scenario: Check that only proper SOFS are counted
  	Given I have a Source of Funds named "Red Cross" with a likelihood of funding of 100% and an amount of $800
	And the "Red Cross" fund is tagged as "assigned"
    And I have a Source of Funds named "United Way" with a likelihood of funding of 100% and an amount of $200
	And the "United Way" fund is tagged as "unassigned"
	And the total of an organization's expenditures is $500
    Then the balance for the "assigned" SOFs should be $"300"