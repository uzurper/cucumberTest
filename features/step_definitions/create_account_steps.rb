require_relative 'site_element.rb'

#define new browser
browser = SiteElement.new("")

Given(/^the user wants to create a new account$/) do
  browser.check_title
end

Given(/^we supply proper credentials$/) do
  browser.create_account_login_name.send_keys "josh"
  browser.create_account_password.send_keys "password"
  browser.create_account_repeat_password.send_keys "password"
end

When(/^we click create account button$/) do
  browser.create_account_button.click
end

Then(/^we should see logged in as new account$/) do
  begin
    browser.check_login_welcome
  ensure
    browser.close_browser
  end
end
