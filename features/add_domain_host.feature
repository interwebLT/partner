Feature: Add Domain Host

  Background:
    Given I am authenticated as staff
    And   I am viewing a domain

  Scenario: Add Domain Host
    When  I add a domain host
    Then  domain must now have domain host

  Scenario: Add Blank Domain Host
    When  I add a blank domain host
    Then  I must be notified that domain host is not valid

  Scenario: Add Existing Domain Host
    When  I add an existing domain host
    Then  I must be notified that domain host is not valid
