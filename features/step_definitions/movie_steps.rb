# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
  #assert false, "Unimplmemented"
end

Given /^(?:|I )check only the following ratings: (.+)$/ do |ratings|
  step %Q{I check the following ratings: '#{ratings}'} unless (ratings =~ /^\s*$/)
  checked_ratings = ratings.split(/\s*,\s*/)
  unchecked_ratings = (['G','PG','PG-13','NC-17','R'].to_set - checked_ratings.to_set).to_a
  step %Q{I uncheck the following ratings: '#{unchecked_ratings.join("','")}'} unless (unchecked_ratings.size == 0)
end

Given /^(?:|I )check no ratings$/ do
  step %Q{I uncheck the following ratings: '#{['G','PG','PG-13','NC-17','R'].join("','")}'}
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #
  # page.content  is the entire content of the page as a string.
  page.body =~ /#{e1}.*#{e2}/
  # assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    rating_not_quoted = rating.gsub(/'/,'')
    #puts "Called with #{uncheck}checked #{rating_not_quoted}"
    step "I #{uncheck}check \"ratings_#{rating_not_quoted}\""
  end
end

Then /^I should see all of the movies$/ do
  within("table#movies tbody") do
    puts "Table has #{all("tr").count} rows"
    all('tr').count.should == Movie.all.count
  end
end

Then /^I should not see any movie$/ do
  within("table#movies tbody") do
    puts "Table has #{all("tr").count} rows"
    all('tr').count.should == 0
  end
end

Then /I should fail/ do
  #pending # express the regexp above with the code you wish you had
  assert false, "Unimplmemented"
end

When /^I click on the title header$/ do
  pending # express the regexp above with the code you wish you had
end
