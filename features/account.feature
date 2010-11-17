Feature: Accounts
  In order to keep track of an account
  As a submitter of budgets
  I want to add and expenditure to an account

  Scenario: Assign expenditure to an account
    Given I have an expenditure with $500
	And the expenditure has a budget object named "chairs"
    And I have an account named "furniture"
	And the account has $1000
    When I press account add
    Then the account dollars should be $1500