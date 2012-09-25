#!/bin/bash
#
# Run this file after you checked out codebase from git
# git clone git@github.com:camilahayashi/goalnect.git
# git clone https://github.com/camilahayashi/goalnect.git
# also install this https://toolbelt.heroku.com/
                                        
brew update #if already installd, otherwise, install homebrew
brew install imagemagick
bundle install
rake db:setup
mailcatcher
rails server
# rake spec


