Feature: Assets
  In order to keep track of Assets
  As a submitter of budgets
  I want describe how much an asset makes for a period

  Scenario: Describe an asset's monthly income
    Given I have an asset named "accounts receivable" which makes $1000 per month
    Then "accounts receivable" income "3" "months" from now should be $3000