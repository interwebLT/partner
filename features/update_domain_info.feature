Feature: Update Domain Info

  Scenario: Update Domain Registrant
    Given I am authenticated as partner
    And   I am viewing a domain
    When  I update the registrant of the domain
    Then  domain registrant must be updated

  Scenario: Update Domain Registrant with Blank Name
    Given I am authenticated as partner
    And   I am viewing a domain
    When  I update the registrant of the domain with a blank local name
    Then  error must be validation failed
