Feature: Book-reader wants to view the Books

  In order to be able to choose read a book
  As a visitor 
  I want to see the listing of all the books

  
  Scenario: Books List
    Given all the books
    When I go to the list of books
    Then I should see all the books 


  Scenario: Show the new book button
    Given the following user records
      | Username | password |
      | admin_ravikukreja2 | storyvarnan2013 |
    When I am logged in as "admin_ravikukreja2" using password "storyvarnan2013"
    Then I should see the "New Books"


