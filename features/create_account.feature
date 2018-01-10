Feature: Create Account Test
  Any person can create an account on the landing page.
 
  Scenario: User supplies proper login name, password, repeat password
    Given the user wants to create a new account
    Given we supply proper credentials
    When we click create account button
    Then we should see logged in as new account
