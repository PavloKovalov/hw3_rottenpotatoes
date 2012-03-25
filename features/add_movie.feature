Feature: add movie to database
 
  As a movie fan
  So that I can add movies to database
  I want to add movie by filling it title, rating and release date

Scenario: Try to add movie
  Given I am on the RottenPotatoes home page
  Then I should see "Add new movie"
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Men In Black"
  And I select "PG-13" from "Rating"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "Men In Black"