Feature: Expense rules
  In order to list a bunch of expense rules easily
  As a dreamer
  I want to create expenses using something similar to english!
  
  Scenario: Add reoccurring expenses
    Given I have a monthly expense of telephone that is $50
    And I have a monthly expense of cell_phone that is $75
    And I have a monthly expense of rent that is $750
    And I have a monthly expense of car_note that is $350
    When I ask for my total monthly expenses
    Then total of the monthly expenses should be $1225

  Scenario: Add one time expense
	Given I have a one time birthday expense of $"250" on "8/3/2011"
	Then the total of the one time expenses should be $250

  Scenario: Add an incremental expense
	Given I have an incremental car_insurance expense of $"600" every 6 months
	Then the total of the incremental expenses should be $600
	
  Scenario: Add a ranged expense
	Given I have a monthly ranged lawn care expense of $"250" from "3/1/2011" to "11/1/2011"
	Then the total of the ranged expenses should be $250
	
  Scenario: Add an expense with a probability
	Given I have a car maintenance expense of $"500" with a chance of 25%
	Then the total of the car maintenance should be $125
	
  Scenario: Add an expense with custom logic
	Given I have "7000" of other expenses
	And I have a tax expense of $"5000" on "4/15/2011" I want to file an extension if my total expenses are more than "10000"
	Then the total expenses at "4/15/2011" should be $7000
