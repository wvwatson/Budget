@rollup
Feature: Rollup rules
  In order to describe what happens when organizations or accounts are rolled up
  As financial personnel
  I want to create rules for rolling up an organization or account

  Scenario: Add rollup rules for organization
    Given I have an organization file named "organization_list.rb"
    And I load the "organization_list.rb" organization file
    And I assign the "executives" organization $1000
	And I assign the "marketing" organization $500 
	And I assign the "software_development" organization $700 
	And I assign the "graphic_design" organization $200
    When I select roll up
    Then the result should be $2400 
