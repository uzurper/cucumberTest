require_relative 'site_element.rb'

#define new browser
browser = SiteElement.new("http://ec2-54-210-168-91.compute-1.amazonaws.com:8666/recruitment/records")

Given(/^the user "(.*?)" has an account$/) do |username|
  browser.check_title
  browser.login_username.clear
  browser.login_username.send_keys username
end

When(/^we login as existing user Kumar$/) do
  browser.login_password.send_keys "password"
  browser.login_button.click
end

When(/^we login as existing user Tomek$/) do
  browser.login_password.send_keys "password"
  browser.login_button.click
end

When(/^we login as existing user Viet$/) do
  browser.login_password.send_keys "password"
  browser.login_button.click
end

When(/^we login as existing user Xing$/) do
  browser.login_password.send_keys "password"
  browser.login_button.click
end

Then(/^we can modify records of direct reportees$/) do
  browser.verify_owner_is_john
  browser.update_john_record
end

Then(/^we can not modify records of his peers$/) do
  browser.verify_owner_is_xing
  browser.update_xing_record
end

Then(/^we can not delete records of his peers$/) do
  browser.verify_owner_is_viet
  browser.delete_viet_record
end

Then(/^we can see his own records$/) do
  browser.verify_owner_is_tomek
end

Then(/^we can see his direct reportees records$/) do
  browser.verify_owner_is_xing
  browser.verify_owner_is_viet
end

Then(/^we should see logged in as "(.*?)"$/) do |username|
  browser.check_login_pass(username)
end

Then(/^we should see welcome message$/) do
  browser.check_login_welcome
end

Then(/^we can click on "(.*?)" link$/) do |records|
  browser.records_link.click
end

Then(/^we can add a record "(.*?)"$/) do |record_content|
  browser.add_new_record_button.click
  browser.add_content(record_content)
end

Then(/^we can click on stats link$/) do
  browser.stats_link.click
end

Then(/^we can update the record to "(.*?)"$/) do |record_content|
  browser.records_link.click
  sleep 1
  browser.add_content(record_content)
end

Then(/^we can delete the last record$/) do
  browser.delete_last_record
end

Then(/^The existing user can logout$/) do
  browser.logout_button.click
end
