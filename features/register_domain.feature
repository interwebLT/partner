Feature: Register Domain

  Background:
    Given I am authenticated as staff

  Scenario: Register available domain
    When  I try register an available domain
    Then  domain must be registered

  Scenario: Register existing domain
    When  I try register an existing domain
    Then  I must be notified that domain is not available for registration

  Scenario: Registrant with no domain
    When  I try to provide the registrant without selecting a domain
    Then  I must be first asked a domain to register

  Scenario: Register invalid domain
    When  I try to register an invalid domain
    Then  I must be notified that domain is not valid

  Scenario: Invalid registrant info
    When  I try to register a domain with invalid registrant info
    Then  I must be notified that the registrant info is not valid

  Scenario: Register domain conflict
    When  I try to register a domain that was registered at the same time
    Then  I must be notified that domain is no longer available
