Feature: Update Domain Info

  Scenario: Update Domain Registrant
    Given I am authenticated as partner
    And   I am viewing a domain
    When  I update the registrant of a domain
    Then  domain registrant must be updated
