Feature: Authenticate User

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

  Scenario: Invalid authentication info
    When  I try to authenticate with invalid authentication info
    Then  I must be notified that authentication failed

  Scenario: Expired authentication token
    Given I am authenticated as partner
    When  I try to navigate the app with an expired authentication token
    Then  I must be prompted to authenticate again
