Feature: Register Domain

  Scenario: Register available domain
    Given I am authenticated as staff
    When  I register an available domain
    Then  domain must be registered
