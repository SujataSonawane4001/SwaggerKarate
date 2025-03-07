Feature: API Tests for Deleting Activities

  Background:
    * def baseUrl = Java.type('com.activitieskarate.config.ConfigActivities').BASE_URL
    * url baseUrl

  Scenario: Delete an existing activities
    Given path 'Activities', 1
    When method DELETE
    Then status 200

  Scenario: Delete a non-existing activities
    Given path 'Activities', 9999
    When method DELETE
    Then status 200

  Scenario: Delete with invalid activity ID
    Given path 'Activities', -1
    When method DELETE
    Then status 200

  Scenario: Delete with non-numeric activity ID
    Given path 'Activities', 'abc'
    When method DELETE
    Then status 400

  Scenario: Verify activity is deleted
    Given path 'Activities', 7
    When method DELETE
    Then status 200

    Given path 'Activities', 7
    When method GET
    Then status 200
