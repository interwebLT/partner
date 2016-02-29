Feature: View Domains

  Background:
    Given I am authenticated as partner

  Scenario: View domains
    When  I try to view my domains
    Then  I must see my domains

  Scenario: View domain info
    When  I try to view the info of one of my domains
    Then  I must see the info of my domain

