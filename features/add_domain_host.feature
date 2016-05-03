Feature: Add Domain Host

  Background:
    Given I am authenticated as staff

  Scenario: Add Domain Host
    Given I am viewing a domain
    When  I add a domain host
    Then  domain must now have domain host
