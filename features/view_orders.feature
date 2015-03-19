Feature: View Orders
  In order to see a list of all my purchases
  As a Partner
  I want to be able to view my orders

  Scenario: View Orders
    Given I am authenticated as partner
    When  I try to view my orders
    Then  I must see my orders
