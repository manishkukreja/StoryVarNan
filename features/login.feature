
Feature:  Login functionality

  In order to be able to post comments
  As a visitor 
  I want to login

  Scenario: Login
    Given I am on login page
    When I am logged in as "admin_ravikukreja2" using password "storyvarnan2013"
    Then I should be able to login to the site.