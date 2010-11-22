Feature: Indirect
  In order to keep track of Indirect money
  As a submitter of budgets
  I want indirect expenditures to roll into indirect accounts

  Scenario: Roll indirect expenditures into an accounts
    Given I have an organization's expenditure tagged as "indirect"
	And the organization's expenditure has $500
	And an organization's account named "indirect"
    When I roll indirect expenditures up
    Then the indirect account should be $500