[![Build Status](https://secure.travis-ci.org/outbrain/onering.png?branch=master)](http://travis-ci.org/outbrain/onering)

What is onering?
= 
Onering is an automation tool for ops. It takes care of the process of provisioning new hosts, monitoring their state as they transition from one phase to the next etc.

Onering also integrates into existing infrastracture components such as Chef.

blah blah blah... need more work...

Developers
=
Setup:
-
- git: http://git-scm.com/download
- Ruby and rails: http://rubyonrails.org/download (use Ruby 1.9.2)
- Mongo: http://www.mongodb.org/display/DOCS/Quickstart (install mongo on the same server as the rails app, it's the easy way... otherwise you'd have to provide configuration URLs for the DB)

Setup Highlights
-
- install rvm: https://rvm.io/rvm/install/
- bundle install
- gem install foreman # make sure you're installing into a decent rvm environment

... this needs more work...


Clone:
-

    $ git clone https://github.com/outbrain/onering.git

Test:
-

    $ bundle exec rspec spec

Configure:
-
- bundle exec rake db:seed

Run the server:
-
Production:

    $ RAILS_ENV=production foreman start


Task management and bugs
-
- For tasks we use Trello [https://trello.com/board/onering/50163a3c2112c4dc4ca29d40](https://trello.com/board/onering/50163a3c2112c4dc4ca29d40)
- For bugs we (will) use github issues [https://github.com/outbrain/onering/issues](https://github.com/outbrain/onering/issues)
- Workflow: We use the [GitHub Flow](http://scottchacon.com/2011/08/31/github-flow.html). In show:
	- Anything in the master branch is deployable
	- To work on something new, create a descriptively named branch off of master (ie: new-oauth2-scopes)
	- Commit to that branch locally and regularly push your work to the same named branch on the server
	- When you need feedback or help, or you think the branch is ready for merging, open a pull request
	- After someone else has reviewed and signed off on the feature, you can merge it into master
	- Once it is merged and pushed to ‘master’, you can and should deploy immediately
