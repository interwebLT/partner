Feature: View Activities

  Scenario: View activities
    Given I am authenticated as administrator
    When  I try to view all activities
    Then  I must see all activities

  Scenario: Partners not allowed to view
    Given I am authenticated as partner
    When  I try to view all activities
    Then  error must be not found
