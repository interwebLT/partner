Feature: Renew Domain

  Scenario: Renew Domain
    Given I am authenticated as staff
    When  I try to renew a domain
    Then  the domain must be renewed