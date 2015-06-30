Feature: Renew Domain
  In order to prevent a domain from expiring
  As a staff member
  I must be able to renew a domain

  Scenario: Renew Domain
    Given I am authenticated as staff
    When  I try to renew a domain
    Then  the domain must be renewed