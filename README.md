# TVM Timing System


[![Build Status](https://travis-ci.com/frizensami/tvm.svg?token=bp4tiJsctMHoyjJscr9k&branch=master)](https://travis-ci.com/frizensami/tvm)


## Setup

1. Install Rails (current rails version on Sriram's PC is Rails 4.2.5). Current Ruby version on Sriram's PC is 2.2.3. Installation instructions can be found at http://installrails.com/ [DO NOT USE A CLOUD VERSION]. Warning: I did not install Rails this way 1 year ago, so be prepared for perhaps a difficult install. Note that the current version of rails is Rails 5, but we're still using Rails 4.
2. (Ignore this step - Disabled Postgres for production) If running in production, set up Postgres. Otherwise, SQLITE will be used. Recommend yall to just use SQLITE for now.
3. Clone this repository to your computer
4. Run `bundle install` to install all prerequisite "gems" (packages)
5. Run `bundle exec rake db:create` to create the required database
6. Run `bundle exec rake db:migrate` to update the database to the current schema
7. (IGNORE THIS STEP: Disabled Postgres for production) If you're using postgres, set up the connection to it by creating an "application.yml" file under config/. This is a slightly involved process as you need to create certain postgres users, set the correct permissions etcs. Recommend that you stick to SQLITE unless you have the time to figure this out.
8. Running `rails -s` will open the development rails server (WEBRick), you can view the application at the endpoint shown in the console
9. Run all the tests with `bundle exec rake test` and all tests should be passing.
10. Ensure that all tests pass before you make any changes
11. If you want to use the legit server: use `unicorn`. To run the exact start script for unicorn in production using the production config: use `./start.sh. For development environment purposes, just enter `unicorn` in the command line, this is basically a replacement for `rails s`.

## Making Changes
1. Create a feature branch (e.g. add-new-stuff)
2. Check that all tests pass
3. Commit to that branch
4. Push to Github and make a pull request.


