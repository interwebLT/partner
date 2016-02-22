Feature: Register Domain

  Background:
    Given I am authenticated as staff

  Scenario: Register available domain
    When  I register an available domain
    Then  domain must be registered

  Scenario: Register existing domain
    When  I register an existing domain
    Then  I must be notified that domain is not available for registration
