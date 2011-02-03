@hours
Feature: Hours rules
  In order to create a daily schedule easily
  As a scheduler
  I want to define hourly tasks using something similar to english!

  Scenario: Add reoccurring hourly tasks
    Given I work on a family web site "1" hour a day
    And I work on at a day job "8" hours a day
    Then the total hours for the day should be 9

  Scenario: Add an incremental task
	Given I have a task named meeting for "1" hour at "9:30" every monday
    Then the total hours for the day should be 1