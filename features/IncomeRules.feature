@income
Feature: Income rules
  In order to list a bunch of income rules easily
  As a dreamer
  I want to create income rules using something similar to english!

  Scenario: Add reoccurring income
    Given I have a monthly income stream of day_job that is $8000
    And I have a monthly income stream of rental_property that is $100
    Then total of the monthly income should be $8100
