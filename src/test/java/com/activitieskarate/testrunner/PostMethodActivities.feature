Feature: API Tests for Creating Activity

  Background:
    * def baseUrl = Java.type('com.activitieskarate.config.ConfigActivities').BASE_URL
    * url baseUrl
    * def requestPayloads = read('classpath:payloads/postActivitiesPayloads.json')

  Scenario: Create activities successfully
    Given path 'Activities'
    And request requestPayloads.validPayload
    When method POST
    Then status 200
    And match response.title == "sujataActivities"
   

  Scenario: Create activites with missing 
    Given path 'Activities'
    And request requestPayloads.payloadWithoutcompleted
    When method POST
    Then status 200
    And match response.title == "sujataActivities"

  Scenario: Create author with duplicate ID
    Given path 'Activities'
    And request requestPayloads.validPayload
    When method POST
    Then status 200

    Given path 'Activities'
    And request requestPayloads.validPayload
    When method POST
    Then status 200
    And match response.id == 123

  Scenario: Create activities with empty payload
    Given path 'Activities'
    And request {}
    When method POST
    Then status 200
    And match response.id == 0
    And match response.title == null
    And match response.completed == false

  
  Scenario: Create actvities with extra fields
    Given path 'Activities'
    And request requestPayloads.payloadWithExtraFields
    When method POST
    Then status 200
    * assert response.extraField == null

 
