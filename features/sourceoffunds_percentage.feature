Feature: Source of Funds
  In order to describe where an organization's budget comes from
  As a submitter of budgets
  I want to assign a percentage of a total budget to a source of funds
  
  Scenario: Assign a percentage
    Given I have an organization with a total budget of $1000
    And I have a Source of Funds named "United Way"
    And that Source of Funds has a percentage of 70%
    And I have another Source of Funds named "Red Cross"
    And that other Source of Funds has a percentage of 30%
    When I select funding distribution
    Then the result should be {"United Way" => 700, "Red Cross" => 300} 
