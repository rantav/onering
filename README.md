[![Build Status](https://secure.travis-ci.org/rantav/onering.png?branch=master)](http://travis-ci.org/rantav/onering)
Setup:
=====
- git: http://git-scm.com/download
- Ruby and rails: http://rubyonrails.org/download (use Ruby 1.9.2)
- Mongo: http://www.mongodb.org/display/DOCS/Quickstart (install mongo on the same server as the rails app, it's the easy way... otherwise you'd have to provide configuration URLs for the DB)
- Heroku: http://devcenter.heroku.com/articles/rails3

Clone:
=====
$ git clone git@github.com:rantav/onering.git

Test:
====
$ bundle exec rspec spec

Configure:
=========
- bundle exec rake db:seed


Run the server:
===================
$ foreman start
Production:
$ RAILS_ENV=production foreman start

Libraries used:
==============
- http://twitter.github.com/bootstrap/ (and https://github.com/twitter/bootstrap)
- http://metaskills.net/2011/09/26/less-is-more-using-twitter-bootstrap-in-the-rails-3-1-asset-pipeline/
- http://activeadmin.info/documentation.html
- https://github.com/cschiewek/devise_ldap_authenticatable

