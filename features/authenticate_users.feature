Feature: Authenticate Users
  In order to manage my domains and other information
  As a User
  I must be able to authenticate with the system

  Scenario: Not authenticated
    Given I am not authenticated
    When  I try to view my domains
    Then  I must be prompted to authenticate

  Scenario: Authenticate as Partner
    When  I try to authenticate as partner
    Then  I must see the homepage of a partner

  Scenario: Authenticate as Administrator
    When  I try to authenticate as administrator
    Then  I must see the homepage of an administrator
