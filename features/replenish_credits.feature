Feature: Replenish Credits
  As a Partner
  I want to be able to replenish my credits

  Background:
    Given I am authenticated as administrator

  @wip
  Scenario: Successful replenishment
    When  I replenish my credits
    Then  my balance should have changed

  @wip
  Scenario: Invalid amount
    When  I try to replenish my credits with an invalid amount
    Then  I should see an error message
