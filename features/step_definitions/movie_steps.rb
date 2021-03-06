# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    @movie = Movie.find_by_title(movie[:title]) || Movie.create!(movie)
    #assert @movie!=nil, "Can't add movie"
  end
  #assert Movie.count === movies_table.hashes.count, "Wrong number of movies added"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body.index(e1) < page.body.index(e2), "Wrong order"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s?/).each do |rating|
    if uncheck === 'un'
      step %Q{I uncheck "#{rating}"}
    else
      step %Q{I check "#{rating}"}
    end
  end
end

Then /I should see all of the movies/ do
  expect_count = Movie.count
  if page.respond_to? :should
    page.should have_css("table#movies tbody tr", :count => expect_count)
  else
    assert page.has_selector?("table#movies tbody tr", :count => expect_count), "Not all the movies displayed"
  end
end

Then /I should not see all of the movies/ do 
  if page.respond_to? :should
    page.should have_no_css("table#movies tbody tr")
  else
    assert page.has_no_selector?("table#movies tbody tr", :count => 0), "Movie list must be empty"
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  movie = Movie.find_by_title(arg1)
  assert movie.director == arg2
end
