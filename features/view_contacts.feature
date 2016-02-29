Feature: View Contacts

  Background:
    Given I am authenticated as administrator

  Scenario: View contacts
    When  I try to view contacts
    Then  I must see all contacts

  Scenario: View contact info
    When  I try to view the info of a contact
    Then  I must see the info of the contact

