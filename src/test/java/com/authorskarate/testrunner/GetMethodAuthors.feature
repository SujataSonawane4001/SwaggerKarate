Feature: API Tests for Authors

  Background:
  * def baseUrl = Java.type('com.authorskarate.config.Config').BASE_URL
  * url baseUrl

  Scenario: Get all authors
    Given path 'Authors'
    When method GET
    Then status 200
    * print response
    * assert response.length > 0
    

  Scenario Outline: Get author by ID
    Given path 'Authors', '<authorId>'
    When method GET
    Then status <statusCode>
    
    Examples:
      | authorId | statusCode |
      | 12345    | 404        |
      
Scenario Outline: Get author by ID
    Given path 'Authors', '<authorId>'
    When method GET
    Then status <statusCode>
    And match response.id == <authorId>
    
    Examples:
      | authorId | statusCode |
      | 1        | 200        |
      
  Scenario: Get authors by book ID
    Given path 'Authors/authors/books/1'
    When method GET
    Then status 200
    And assert response.length > 0

  Scenario: Get authors with invalid ID format
    Given path 'Authors', 'abc'
    When method GET
    Then status 400
