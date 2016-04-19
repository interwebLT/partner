Feature: Remove Domain Host

  Background:
    Given I am authenticated as staff

  Scenario: Remove domain host
    Given I am viewing a domain
    When  I remove a domain host
    Then  domain host must be removed

  Scenario: Remove domain host that does not exist
    Given I am viewing a domain
    When  I remove a domain host that does not exist
    Then  error must be not found
