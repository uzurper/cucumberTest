Feature: Core Functionality - Smoke Test
  Kumar is an existing user of the simple web app. The first scenario covers
  the core functionality of the app: login, CRUD operations, logout. Specifically,
  the following core features are verified: 2. A user can create a new record.
  After that, the record will appear on his record list. 3. A user can update and
  delete his records.

  Tomek is an existing user of the simple web app. The second scenario covers
  the fourth core functionality of the app: 4. When a user enters the record list
  page, in addition to his records he can also see records of his direct reportees
  and of his peers.

  John reports to Viet. The third scenario covers the fifth core functionality of
  the app: 5. A user can modify records of his direct reportees, but not of his peers.

  Xing and Viet are peers. The fourth scenario covers the sixth core functionality
  of the app: 6. A user cannot delete other records than his own.

  Scenario: Kumar user can perform core functionality 1. 2. 3.
    Given the user "kumar" has an account
    When we login as existing user Kumar
    Then we should see logged in as "kumar"
    Then we should see welcome message
    Then we can click on "records" link
    Then we can add a record "test record 49"
    Then we can click on stats link
    Then we can update the record to "test record 50"
    Then we can delete the last record
    Then The existing user can logout

  Scenario: Tomek user can perform core functionality 4.
    Given the user "tomek" has an account
    When we login as existing user Tomek
    Then we should see logged in as "tomek"
    Then we should see welcome message
    Then we can see his own records
    Then we can see his direct reportees records
    Then The existing user can logout

  Scenario: Viet user can perform core functionality 5.
    Given the user "viet" has an account
    When we login as existing user Viet
    Then we should see logged in as "viet"
    Then we should see welcome message
    Then we can modify records of direct reportees
    Then we can not modify records of his peers
    Then The existing user can logout

  Scenario: Xing user can perform core functionality 5.
    Given the user "xing" has an account
    When we login as existing user Xing
    Then we should see logged in as "xing"
    Then we should see welcome message
    Then we can not delete records of his peers
    Then The existing user can logout
