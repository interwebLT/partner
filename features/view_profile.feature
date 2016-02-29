Feature: View Profile

  Scenario: View profile
    Given I am authenticated as partner
    When  I try to view my profile information
    Then  I must see my profile information
