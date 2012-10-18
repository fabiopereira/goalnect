# http://mattonrails.wordpress.com/2011/06/08/jenkins-homebrew-mac-daemo/
brew install jenkins
# If this is your first install, automatically load on login with:
#   mkdir -p ~/Library/LaunchAgents
#   ln -nfs /usr/local/Cellar/jenkins/1.484/homebrew.mxcl.jenkins.plist ~/Library/LaunchAgents/
#   launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist
# 
# If this is an upgrade and you already have the homebrew.mxcl.jenkins.plist loaded:
#   launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist
#   launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist
# 
# Or start it manually:
#   java -jar /usr/local/Cellar/jenkins/1.484/libexec/jenkins.war
# Find where your jenkins-cli is
# sudo find /usr/local/Cellar/jenkins -name jenkins-cli.jar
# 
# java -jar /Users/fpereira/.jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ help
# ##############################
# Install Jenkins Plugins 
# Git Plugin 
# Github plugin
# Ruby metrics plugin
# Rake plugin
# Html Publisher
# ##############################


see this
https://github.com/fabn/rails-jenkins-template