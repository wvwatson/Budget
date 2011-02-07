@organization
Feature: Organization file load
  In order to load a bunch of organizations easily
  As financial personnel 
  I want to load all of the hourly task rules from a task file
  
  Scenario: Load from organization_list.rb
    Given I have an organization file named "organization_list.rb"
    And I load the "organization_list.rb" hours file
    When I generate the organizations
    Then the total organizations collected should be 13
