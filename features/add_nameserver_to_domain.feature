Feature: Add Nameserver to Domain

  @wip
  Scenario: Add host
    Given I am authenticated as staff
    When  I try to add a host
    Then  the host must be added to the domain
