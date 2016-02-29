Feature: View Profile

  Scenario: View partner info
    Given I am authenticated as partner
    When  I try to view my partner information
    Then  I must see my partner information
