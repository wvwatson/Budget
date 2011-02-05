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

  Scenario: Add one time task
	Given I have a one time medical checkup for "4" hours on "8/3/2011"
    Then the total hours for the day should be 4

  Scenario: Add one time task in one line
	Given I have a one time medical checkup for "4" hours on "8/3/2011" on one line
    Then the total hours for the day should be 4

  Scenario: Replace a task's hours to another task
	Given I have some tasks set up
	And I replace all of the day's hours as a sick day
    Then the total hours for the day should be 9 and the tasks should be assigned to sick day

  Scenario: Add a ranged task
	Given I have a side project meeting lasting "1" hour from "3/1/2011" to "5/1/2011" every monday at "10:30"
    Then the total hours for the day should be 1
	
