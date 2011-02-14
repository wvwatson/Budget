@rollup
Feature: Rollup rules
  In order to describe what happens when organizations or accounts are rolled up
  As financial personnel
  I want to create rules for rolling up an organization or account

  Scenario: Add rollup rules for organization
    Given I have a rollup rules file named "rollup_list.rb"
    And I load the "rollup_list.rb" rollup file
    Then the total rollup rules collected should be 3


  Scenario: Rollup an organization using rollup rules
  	Given I have organizations set up
	And I have rollup rules set up
    And I assign the "executives" organization $1000
	And I assign the "marketing" organization $500 
	And I assign the "software_development" organization $700 
	And I assign the "graphic_design" organization $200
    Then the rollup result should be $2400
