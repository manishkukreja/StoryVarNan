Given(/^I am on login page$/) do
   visit login_url
end


When(/^I am logged in as "(.*?)" using password "(.*?)"$/) do |username, password|
   fill_in "Username", :with => username
  fill_in "Password", :with => password
  click_button "Create User session"
end

Then(/^I should be able to login to the site\.$/) do
  response.should contain(/Sucess/)
end
