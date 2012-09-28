#!/bin/bash
#
# Run this file after you checked out codebase from git
# git clone git@github.com:camilahayashi/goalnect.git
# git clone https://github.com/camilahayashi/goalnect.git
# also install this https://toolbelt.heroku.com/
# Install RVM https://rvm.io/rvm/install/
# Install Bundler http://gembundler.com/

# Tutorial
# http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/
# Google and download GCC-10.7-v2.pkg
                                        
brew update #if already installd, otherwise, install homebrew
brew install imagemagick

#To run tests successfully you install QT
http://doc.qt.digia.com/latest/requirements-mac.html
//connect.apple.com
https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit
brew install qt
# or if above doesn't work
brew install qt --build-from-source


bundle install
rake db:setup
mailcatcher
rails server
# rake spec
