Feature: Remove Domain Host

  Background:
    Given I am authenticated as staff

  Scenario: Remove domain host
    Given I am viewing a domain
    When  I remove a domain host
    Then  domain host must be removed
