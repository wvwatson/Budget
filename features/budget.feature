Feature: Budget
  In order to monitor an organization's budget
  As a reviewer of budgets
  I want to roll a sub-organization's numbers into its parent organization
  
  Scenario: Roll up a budget
    Given I have an organization with $1000
    And I have a sub organization1 with $500
    And I have a sub organization2 with $1000
    When I select roll up
    Then the result should be $2500 
