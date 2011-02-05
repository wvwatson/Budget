@hours
Feature: Hourly tasks file load
  In order to load a bunch of hours rules easily
  As a task scheduler 
  I want to load all of the hourly task rules from a task file
  
  Scenario: load from hours_list.rb
    Given I have an hours file named "hours_list.rb"
    And I load the "hours_list.rb" hours file
    When I generate the hourly tasks
    Then the total hours collected should be 19
