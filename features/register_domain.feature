Feature: Register Domain

  @wip
  Scenario: Register available domain
    When  I register an available domain
    Then  domain must be registered
