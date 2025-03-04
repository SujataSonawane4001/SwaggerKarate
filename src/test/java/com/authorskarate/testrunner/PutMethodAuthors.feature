Feature: API Tests for Updating Authors

  Background:
    * def baseUrl = Java.type('com.authorskarate.config.Config').BASE_URL
    * url baseUrl
    * def requestPayloads = read('classpath:payloads/putAuthorsPayloads.json')

  Scenario: Update author with valid payload
    Given path 'Authors/123'
    And request requestPayloads.validPayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.idBook == 789
    And match response.firstName == "Chaitanya"
    And match response.lastName == "Purohit"

  Scenario: Update author with empty payload
    Given path 'Authors/123'
    And request requestPayloads.emptyPayload
    When method PUT
    Then status 200
    And match response.id == 0
    And match response.idBook == 0
    And match response.firstName == null
    And match response.lastName == null

  Scenario: Update author with missing fields
    Given path 'Authors/123'
    And request requestPayloads.incompletePayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.idBook == 0
    And match response.firstName == null
    And match response.lastName == null

  Scenario: Update author with invalid ID format
    Given path 'Authors/abc'
    And request requestPayloads.validPayload
    When method PUT
    Then status 400

  Scenario: Update author with non-existent ID
    Given path 'Authors/9999'
    And request requestPayloads.validPayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.idBook == 789
    And match response.firstName == "Chaitanya"
    And match response.lastName == "Purohit"

  Scenario: Update author with special character ID
    Given path 'Authors/!@#'
    And request requestPayloads.validPayload
    When method PUT
    Then status 400

  Scenario: Update author with negative ID
    Given path 'Authors/- 123'
    And request requestPayloads.validPayload
    When method PUT
    Then status 400

  Scenario: Update author with unexpected fields
    Given path 'Authors/123'
    And request requestPayloads.extraFieldsPayload
    When method PUT
    Then status 200
    And match response.id == 123
    And match response.idBook == 789
    And match response.firstName == "Chaitanya"
    And match response.lastName == "Purohit"
