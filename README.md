# cucumberTest
homework for testing a simple web app

## Setup instructions on Mac OS 10.13

0. Install Homebrew - https://brew.sh/
1. Install Ruby
```
$ brew install ruby
```
2. Install some gems
```
$ gem install selenium-webdriver
$ gem install cucumber
$ gem install rspec-expectations
```

3. Install latest Firefox - https://www.mozilla.org
4. download latest geckodriver - https://developer.mozilla.org/en-US/docs/Mozilla/QA/Marionette/WebDriver
5. Save location of geckodriver - add PATH in Shell Profile

## How to build
- just clone from github

```
git clone https://github.com/uzurper/cucumberTest.git
```

## How to launch tests

- update URL in `core_steps.rb` and `create_account_steps.rb` specifically line 4
- change dirctory to `cucumberTest` and run from command line

```
$ cucumber
```

## How to see test results:
```
$ cucumber --format html --out report.html
```

this will create a report.html file, which you can open with your favorite browser.
```
$ open report.html
```

An example report.html is included in this repository.
