Feature: View Hosts

  Background:
    Given I am authenticated as administrator

  Scenario: View hosts
    When  I try to view hosts
    Then  I must see all hosts

  Scenario: View host info
    When  I try to view the info of a host
    Then  I must see the info of the host

