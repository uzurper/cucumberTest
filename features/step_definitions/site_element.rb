require 'selenium-webdriver'
require 'rspec/expectations'

class SiteElement
  include RSpec::Matchers

  def initialize(url)
    @driver=Selenium::WebDriver.for :firefox
    #@driver.manage.window.maximize
    @driver.navigate.to url
  end

  # helper function for page loading... 'sigh'
  def try_for(timeout = 30, polling_interval = 1, &block)
    start_time = Time.now
    last_error = nil
    until (duration = Time.now - start_time) > timeout
      begin
        yield
        last_error = nil
        return true
      rescue => e
        last_error = e
      end
      sleep polling_interval
    end
    raise "Timeout after #{duration.to_i} seconds with error: #{last_error}." if last_error
    raise "Timeout after #{duration.to_i} seconds."
  end

  def check_title() # assert we see the correct page
    sleep 1
    try_for(5) { expect(@driver.title).to eq("test app") }
  end

  def login_username() # login name text field by class
    try_for(5) { expect(@driver.find_element(:xpath, "//button[contains(text(), 'create account')]")) }
    return @driver.find_element(:class, "gwt-TextBox")
  end

  def login_password() # password text field by class
    try_for(5) { return @driver.find_element(:class, "gwt-PasswordTextBox") }
  end

  def login_button() # login button by xpath
    try_for(5) { return @driver.find_element(:xpath, "//button[contains(text(), 'login')]") }
  end

  def check_login_pass(user)
    try_for(5) { expect(@driver.find_element(:xpath, "//div[contains(text(), user)]")) }
  end

  def check_login_welcome()
    try_for(5) { expect(@driver.find_element(:xpath, "//div[contains(text(), 'welcome :)')]")) }
  end

  def records_link() # records link by link_text
    try_for(5) { return @driver.find_element(:link_text, "records") }
  end

  def add_new_record_button()
    try_for(5) { return @driver.find_element(:xpath, "//table/tbody/tr[2]/td/button[contains(text(), 'add new record')]") }
  end

  def add_content(record_content)
    # there may be multiple rows, so we have to submit content to last row
    content_rows = @driver.find_elements(:class, "gwt-TextBox")
    last_row = content_rows.count - 1
    content_rows[last_row].send_keys(record_content)

    # there may be multiple save buttons, so we have to click the save button on the last row
    save_rows = @driver.find_elements(:xpath, "//button[contains(text(), 'save')]")
    last_save_btn = save_rows.count - 1
    save_rows[last_save_btn].click

    #verify you see saved
    try_for(5) { expect(@driver.find_element(:xpath, "//div[contains(text(), 'record saved')]")) }
  end

  def stats_link()
    try_for(5) { return @driver.find_element(:link_text, "stats") }
  end

  def delete_last_record()
    # there may be multiple delete buttons, so we have to click the delete button on the last row
    del_rows = @driver.find_elements(:xpath, "//button[contains(text(), 'delete')]")
    last_save_btn = del_rows.count - 1
    del_rows[last_save_btn].click

    # verify you see 'record deleted'
    try_for(5) { expect(@driver.find_element(:xpath, "//div[contains(text(), 'record deleted')]")) }
  end

  def logout_button()
    return @driver.find_element(:xpath, "//button[contains(text(),'logout')]")
  end

  def close_browser()
    @driver.quit
  end

  def create_account_login_name()
    try_for(5) { expect(@driver.find_element(:xpath, "//button[contains(text(), 'create account')]")) }
    return @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/div/table/tbody/tr[1]/td[2]/input")
  end

  def create_account_password()
    try_for(5) { expect(@driver.find_element(:xpath, "//button[contains(text(), 'create account')]")) }
    return @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/div/table/tbody/tr[2]/td[2]/input")
  end

  def create_account_repeat_password()
    try_for(5) { expect(@driver.find_element(:xpath, "//button[contains(text(), 'create account')]")) }
    return @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/div/table/tbody/tr[3]/td[2]/input")
  end

  def create_account_button()
    try_for(5) { return @driver.find_element(:xpath, "//button[contains(text(), 'create account')]") }
  end

  def verify_owner_is_tomek()
    try_for(5) { expect(@driver.find_elements(:xpath, "//div[contains(text(), 'tomek')]")) }
  end

  def verify_owner_is_xing()
    try_for(5) { expect(@driver.find_elements(:xpath, "//div[contains(text(), 'xing')]")) }
  end

  def verify_owner_is_viet()
    try_for(5) { expect(@driver.find_elements(:xpath, "//div[contains(text(), 'viet')]")) }
  end

  def verify_owner_is_john()
    try_for(5) { expect(@driver.find_elements(:xpath, "//div[contains(text(), 'john')]")) }
  end

  def update_john_record()
    # assuming viet sees john's record as the first row in table
    sleep 1
    first_row = @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/table/tbody/tr[1]/td/table/tbody/tr[2]/td[1]/input")
    first_row.clear
    first_row.send_keys "update test"

    # assuming we can try click first save button
    first_save_btn = @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/table/tbody/tr[1]/td/table/tbody/tr[2]/td[3]/button")
    first_save_btn.click

    #verify you see saved
    try_for(5) { expect(@driver.find_element(:xpath, "//div[contains(text(), 'record saved')]")) }

    # now lets undo the update to the record
    first_row.clear
    first_row.send_keys "john2"
    first_save_btn.click
  end

  def verify_owner_is_xing()
    try_for(5) { expect(@driver.find_elements(:xpath, "//div[contains(text(), 'xing')]")) }
  end

  def update_xing_record()
    # assuming viet sees xing's record as the 12th row in table
    sleep 1
    twelfth_row = @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/table/tbody/tr[1]/td/table/tbody/tr[13]/td[2]/div")
    twelfth_row.send_keys "abc123"

    # assuming we can try click 12th save button
    twelfth_save_btn = @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/table/tbody/tr[1]/td/table/tbody/tr[13]/td[3]/button")
    twelfth_save_btn.click

    #verify you see permission denied
    try_for(5) { expect(@driver.find_element(:xpath, "//div[contains(text(), 'permission denied')]")) }
  end

  def delete_viet_record()
    # assuming xing see's viet's record as the sixth row in the table, we try to click seventh delete button
    sleep 1
    seventh_delete_btn = @driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/div[6]/div/div/table/tbody/tr[1]/td/table/tbody/tr[8]/td[4]/button")
    seventh_delete_btn.click

    #verify you see permission denied
    try_for(5) { expect(@driver.find_element(:xpath, "//div[contains(text(), 'permission denied')]")) }
  end
end
