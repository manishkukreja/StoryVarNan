Given(/^all the books$/) do
  pending # express the regexp above with the code you wish you had
end


When(/^I go to the list of books$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see all the books$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^the following user records?$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl(:user, hash)
  end
end

When(/^I am logged in as "([.*?])" using password "(.*?)"$/) do |username, password|
  visit login_url
  fill_in "Username", :with => username
  fill_in "Password", :with => password
  click_button "Log in"

end

Then(/^I should see the "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end


