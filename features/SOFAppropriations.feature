Feature: SOF appropriations
  In order to keep track of the appropriations (restrictions) for a Source of Funds
  As financial personnel
  I want to retrieve all SOF funds available for a task.

  Scenario: Get all funds available for unrestricted activities
    Given I have a Source of Funds named "Red Cross" with a likelihood of funding of 100% and an amount of $10000
	And the "Red Cross" fund is tagged as "unrestricted"
    And I have a Source of Funds named "United Way" with a likelihood of funding of 100% and an amount of $1000
	And the "United Way" fund is tagged as "unrestricted"
    And I have a Source of Funds named "UNICEF" with a likelihood of funding of 100% and an amount of $2000
	And the "UNICEF" fund is tagged as "restricted"
    Then the "unrestricted" funds available should be $11000