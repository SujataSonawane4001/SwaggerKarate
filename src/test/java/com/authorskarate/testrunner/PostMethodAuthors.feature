Feature: API Tests for Creating Authors

  Background:
    * def baseUrl = Java.type('com.authorskarate.config.Config').BASE_URL
    * url baseUrl
    * def requestPayloads = read('classpath:payloads/postAuthorsPayloads.json')

  Scenario: Create author successfully
    Given path 'Authors'
    And request requestPayloads.validPayload
    When method POST
    Then status 200
    And match response.firstName == "Chaitanya"
    And match response.lastName == "Purohit"

  Scenario: Create author with missing last name
    Given path 'Authors'
    And request requestPayloads.payloadWithoutName
    When method POST
    Then status 200
    And match response.lastName == null

  Scenario: Create author with duplicate ID
    Given path 'Authors'
    And request requestPayloads.validPayload
    When method POST
    Then status 200

    Given path 'Authors'
    And request requestPayloads.validPayload
    When method POST
    Then status 200
    And match response.id == 123

  Scenario: Create author with empty payload
    Given path 'Authors'
    And request {}
    When method POST
    Then status 200
    And match response.id == 0
    And match response.firstName == null
    And match response.lastName == null

  Scenario: Create author with invalid data types
    Given path 'Authors'
    And request requestPayloads.invalidPayloadNamesAsInt
    When method POST
    Then status 400
    * print response
    And match response.id == null
    And match response.firstName == null

  Scenario: Create author with extra fields
    Given path 'Authors'
    And request requestPayloads.payloadWithExtraFields
    When method POST
    Then status 200
    And match response.extraField == null

  Scenario: Create author with null fields
    Given path 'Authors'
    And request requestPayloads.payloadWithNullFields
    When method POST
    Then status 400
    And match response.id == null
    And match response.firstName == null
