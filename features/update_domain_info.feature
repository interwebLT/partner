Feature: Update Domain Info

  Background:
    Given I am authenticated as staff

  Scenario: Update Domain Registrant
    Given I am viewing a domain
    When  I update the registrant of the domain
    Then  domain registrant must be updated

  Scenario Outline: Update Domain Registrant with Invalid Data
    Given I am viewing a domain
    When  I update the registrant of the domain with a <invalid data>
    Then  error must be validation failed

    Examples:
      | invalid data              |
      | blank local name          |
      | blank local organization  |
