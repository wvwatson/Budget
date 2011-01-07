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

