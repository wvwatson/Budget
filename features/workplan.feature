Feature: Work
  In order to create a workplan
  As an executive
  I want to create a list of goals and action steps to complete those goals

  Scenario: Add some goals
    Given I have entered "Lower costs by 10%" as the first goal
	And I have entered "Increase Income by 5%" as the second goal
    When I press show workplan
    Then the result should be "Lower costs by 10%" and "Increase Income by 5%" on the screen
