Feature: Indirect
  In order to keep track of Indirect money
  As a submitter of budgets
  I want indirect expenditures to roll into indirect accounts

  Scenario: Roll indirect expenditures into an accounts
    Given I have a expenditure tagged as "indirect"
	And the expenditure has $500
    When I roll indirect expenditures up
    Then the indirect account should be $500