Feature: View Reports

  Scenario: View Orders
    Given I am authenticated as partner
    When  I try to view my orders
    Then  I must see my orders
