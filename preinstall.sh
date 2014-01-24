#!/bin/bash
#set -e
#set -x

# Preinstall Prerequisit
command -v bundle || { echo "WARNING: Bundler missing. Run 'gem install bundler'"; }

egrep -i "^redmine" /etc/group > /dev/null 2>&1 || { echo 'Create redmine account'; \
groupadd -r redmine; } 

egrep -i "^redmine" /etc/passwd > /dev/null 2>&1 || { echo 'Create redmine account'; \
adduser -g redmine --shell /bin/bash --home /opt/redmine --comment "Redmine user for managing Redmine process" redmine; }

