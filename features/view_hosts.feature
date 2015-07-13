Feature: View hosts
  In order to see a list of all hosts
  As an admin
  I want to be able to view all hosts

  Background:
    Given I am authenticated as administrator

  Scenario: View hosts
    When  I try to view hosts
    Then  I must see all hosts

  Scenario: View host info
    When  I try to view the info of a host
    Then  I must see the info of the host

