Feature: Register Domain

  Background:
    Given I am authenticated as staff

  Scenario: Register available domain
    When  I try to register an available domain
    And   I provide valid domain details
    And   I accept the registration details and charges
    Then  domain must be registered

  Scenario: Register available domain in all caps
    When  I try to register an available domain in all caps
    And   I provide valid domain details
    And   I accept the registration details and charges
    Then  domain must be registered

  Scenario: Register existing domain
    When  I try to register an existing domain
    Then  I must be notified that domain is not available for registration

  Scenario: Registrant with no domain
    When  I try to provide the registrant without selecting a domain
    Then  I must be prompted for a valid domain to register

  Scenario: Register invalid domain
    When  I try to register an invalid domain
    Then  I must be notified that domain is not valid

  Scenario: Invalid registrant info
    When  I try to register an available domain
    But   I provide invalid registrant info
    Then  I must be notified that the registrant info is not valid

  Scenario: Register domain conflict
    When  I try to register a domain that was registered at the same time
    Then  I must be notified that domain is no longer available

  Scenario: Registrant handle exists
    When  I try to provide a registrant with existing handle
    Then  I must be notified that the registrant already exists

  Scenario: Correct domain details
    When  I try to register an available domain
    And   I provide valid domain details
    But   I did not accept the domain details as I have a correction
    Then  I must be able to correct my domain details

  Scenario: Correct domain details when domain is invalid
    When  I try to correct domain details when domain is invalid
    Then  I must be prompted for a valid domain to register

  Scenario: Correct domain details when domain exists
    When  I try to correct domain details when domain exists
    Then  I must be prompted for a valid domain to register

  Scenario: Correct domain details when period is invalid
    When  I try to correct domain details when period is invalid
    Then  I must provide period as it is blank

  Scenario: Correct domain details when registrant is invalid
    When  I try to correct domain details when registrant is invalid
    Then  I must provide registrant info as it is blank

  Scenario: Confirm registration details when domain is invalid
  Scenario: Confirm registration details when domain exists

  Scenario: Confirm registration details when period is invalid
    When  I try to confirm registration details when period is invalid
    Then  I must provide period as it is blank

  Scenario: Confirm registration details when registrant is invalid
    When  I try to confirm registration details when registrant is invalid
    Then  I must provide registrant info as it is blank
