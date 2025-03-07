Feature: API Tests for Updating Activities

  Background:
    * def baseUrl = Java.type('com.activitieskarate.config.ConfigActivities').BASE_URL
    * url baseUrl
    * def requestPayloads = read('classpath:payloads/putActivitiesPayloads.json')

  Scenario: Update activity with valid payload
    Given path 'Activities/123'
    And request requestPayloads.validPayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.title == "sujataActivities"
    And match response.completed == true
  

  Scenario: Update activity with empty payload
    Given path 'Activities/123'
    And request requestPayloads.emptyPayload
    When method PUT
    Then status 200
    And match response.id == 0
    And match response.title == null
    And match response.completed == false

  Scenario: Update activity with missing fields
    Given path 'Activities/123'
    And request requestPayloads.incompletePayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.title == null
    And match response.completed == false

  Scenario: Update activity with invalid ID format
    Given path 'Activities/abc'
    And request requestPayloads.validPayload
    When method PUT
    Then status 400

  Scenario: Update author with non-existent ID
    Given path 'Activities/9999'
    And request requestPayloads.validPayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.title == "sujataActivities"
    And match response.completed == true
  

  Scenario: Update author with special character ID
    Given path 'Activities/!@#'
    And request requestPayloads.validPayload
    When method PUT
    Then status 400

  Scenario: Update author with negative ID
    Given path 'Activities/-123'
    And request requestPayloads.validPayload
    When method PUT
    Then status 200

  Scenario: Update author with unexpected fields
    Given path 'Activities/123'
    And request requestPayloads.extraFieldsPayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.title == "sujataActivities"
    And match response.completed == true
  
