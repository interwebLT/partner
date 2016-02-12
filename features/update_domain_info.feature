Feature: Update Domain Info

  Scenario: Update Domain Registrant
    Given I am authenticated as partner
    And   I am viewing a domain
    When  I update the registrant of the domain
    Then  domain registrant must be updated
