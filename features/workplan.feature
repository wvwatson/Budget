Feature: Work
  In order to create a workplan
  As an executive
  I want to create a list of goals and action steps to complete those goals

  Scenario: Add some goals
    Given I have entered "Lower costs by 10%" as the first goal
	And I have entered "Increase Income by 5%" as the second goal
    When I press show workplan
    Then the result should be "Lower costs by 10%" and "Increase Income by 5%" on the screen

Scenario: Assign some actions to a goal
	Given I have entered "Lower costs by 10%" as the first goal
	And I have entered "Increase Income by 5%" as the second goal
    And I have entered "Create a new shortlist of lower priced vendors for office consumables" and assigned it to the "Lower costs by 10%" goal as the first action
	And I have entered "Issue an RFQ for lower priced computers" and assigned it to the "Lower costs by 10%" goal as the second action
    When I display the "Lower costs by 10%" goal
    Then the result should be "Create a new shortlist of lower priced vendors for office consumables" and "Issue an RFQ for lower priced computers" on the screen for the "Lower costs by 10%" goal
	