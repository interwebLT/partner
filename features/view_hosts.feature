Feature: View hosts
  In order to see a list of all hosts
  As an admin
  I want to be able to view all hosts

  Background:
    Given I am authenticated as administrator

  Scenario: View hosts
    When  I try to view hosts
    Then  I must see all hosts
