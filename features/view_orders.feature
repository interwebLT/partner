Feature: View Orders

  Scenario: View latest orders
    Given I am authenticated as administrator
    When  I try to view the latest purchases in my zone
    Then  I must see the latest orders
