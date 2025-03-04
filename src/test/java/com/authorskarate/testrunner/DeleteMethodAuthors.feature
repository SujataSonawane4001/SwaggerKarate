Feature: API Tests for Deleting Authors

  Background:
    * def baseUrl = Java.type('com.authorskarate.config.Config').BASE_URL
    * url baseUrl

  Scenario: Delete an existing author
    Given path 'Authors', 5
    When method DELETE
    Then status 200

  Scenario: Delete a non-existing author
    Given path 'Authors', 9999
    When method DELETE
    Then status 404

  Scenario: Delete with invalid ID
    Given path 'Authors', -1
    When method DELETE
    Then status 400

  Scenario: Delete with non-numeric ID
    Given path 'Authors', 'abc'
    When method DELETE
    Then status 400

  Scenario: Verify author is deleted
    Given path 'Authors', 7
    When method DELETE
    Then status 200

    Given path 'Authors', 7
    When method GET
    Then status 404
