Feature: Estimated Income
  In order to create a estimations of income
  As an executive
  I want to create a list of estimated income from source of funds.

  Scenario: Get the total estimated income
    Given I have a Source of Funds named "Red Cross" with a likelihood of funding of 70% and an amount of $10000
    And I have a Source of Funds named "United Way" with a likelihood of funding of 30% and an amount of $1000
    Then the Income Estimation should be $7300

