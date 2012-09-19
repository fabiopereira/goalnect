#!/bin/bash
# Run this file after you checked out codebase from git
# git clone git@github.com:camilahayashi/goalnect.git
# git clone https://github.com/camilahayashi/goalnect.git

bundle install
rake db:setup
mailcatcher
rails server
# run tests

