# TVM Timing System


[![Build Status](https://travis-ci.com/frizensami/tvm.svg?token=bp4tiJsctMHoyjJscr9k&branch=master)](https://travis-ci.com/frizensami/tvm)


## Setup

1. Install Rails (current rails version on Sriram's PC is Rails 4.2.5). Current Ruby version on Sriram's PC is 2.2.3. Installation instructions can be found at http://installrails.com/ [DO NOT USE A CLOUD VERSION]. Warning: I did not install Rails this way 1 year ago, so be prepared for perhaps a difficult install. Note that the current version of rails is Rails 5, but we're still using Rails 4.
2. (Ignore this step - Disabled Postgres for production) If running in production, set up Postgres. Otherwise, SQLITE will be used. Recommend yall to just use SQLITE for now.
3. Clone this repository to your computer
4. Run `bundle install` to install all prerequisite "gems" (packages)
5. Run `bundle exec rake db:create` to create the required database
6. Run `bundle exec rake db:migrate` to update the database to the current schema
7. Run `bundle exec rake tvm:import_participants_tsv` to import participants from `master.tsv` file for TVM 2017. If you want to reset your database - aka drop all tables and data and re-migrate the schema, run `bundle exec rake db:reset`. (OLD: Run `bundle exec rake csv:import_participants` to use the `participants.csv` file from last year to populate the development database.)
7. (IGNORE THIS STEP: Disabled Postgres for production) If you're using postgres, set up the connection to it by creating an "application.yml" file under config/. This is a slightly involved process as you need to create certain postgres users, set the correct permissions etcs. Recommend that you stick to SQLITE unless you have the time to figure this out.
8. Running `rails -s` will open the development rails server (WEBRick), you can view the application at the endpoint shown in the console
9. Run all the tests with `bundle exec rake test` and all tests should be passing.
10. Ensure that all tests pass before you make any changes
11. If you want to use the legit server: use `unicorn`. To run the exact start script for unicorn in production using the production config: use `./start.sh.`For development environment purposes, just enter `unicorn` in the command line, this is basically a replacement for `rails s`.
12. You may want to set up NGINX as a reverse proxy to forward requests from port 80 to the Rails unicorn socket. I used a DigitalOcean tutorial to figure this out.

## Making Changes
1. Create a feature branch (e.g. add-new-stuff)
2. Check that all tests pass
3. Commit to that branch
4. Push to Github and make a pull request.

## Changes for 2017
Participants are now in one of 6 categories, and their timing is only relevant within their individual categories: 

1. Couple + NUS (CN)
2. Female + NUS (FN)
3. Men + NUS (MN)
4. Men + Open (MO)
5. Team + NUS (TN)
6. Women + Open (WO)

A **couple** is made of two members, and the couple's final time is **the sum of their individual timings**. A team is made of **some number of members** with their final time also as **the sum of their individual timings**. Anyone else has their timings unchanged (still individual timings).

The important change is that there now are 6 "sub-competitions" within TVM, each with their own set of timings that do not cross-compete.

### Architectural decisions and definitions to support new behavior
1. Every single person is part of a logical **team**.
2. An **individual participant** is in a team with **only one member**, themselves.
3. A **couple** is defined as a **team with 2 members**. 
4. A **team** as registered in TVM is just a team with **> 2 members** but this is generally irrelevant.
5. Any "team timings" are computed as **sum of timings of team members**. Therefore timings for individuals are unchanged since it's a sum with only one operand. 

### Why?
1. This means that a simple table can be created called "teams". A **team** has a one-to-many relationship with **participant**. This causes minimal changes to the overall structure of the codebase since **participant** directly does not need to have knowledge of what **team** they are in - as this can be computed at import-time.





