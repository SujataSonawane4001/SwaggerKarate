Feature: API Tests for Activities

  Background:
  * def baseUrl = Java.type('com.activitieskarate.config.ConfigActivities').BASE_URL
  * url baseUrl

  Scenario: Get all activities
    Given path 'Activities'
    When method GET
    Then status 200
    * print response
    * assert response.length > 0
    

  Scenario Outline: Get Activity by ID
    Given path 'Activities', '<activityId>'
    When method GET
    Then status <statusCode>
    
    Examples:
      | activityId | statusCode |
      | 12345    | 404        |
      
 Scenario Outline: Get activity by ID
    Given path 'Activities', '<activityId>'
    When method GET
    Then status <statusCode>
    And match response.id == <activityId>
    
    Examples:
      | activityId | statusCode |
      | 1        | 200        |
      

  Scenario: Get activities with invalid ID format
    Given path 'Activities', 'abc'
    When method GET
    Then status 400
