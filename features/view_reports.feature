Feature: View Reports

  Scenario: View reports
    Given I am authenticated as partner
    When  I try to view my reports
    Then  I must see all my orders
    Then  I must see all my credit replenishments
