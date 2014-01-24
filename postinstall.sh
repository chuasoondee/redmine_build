#!/bin/bash

chown -R redmine:redmine /opt/redmine

# pushd /opt/redmine
# command -v bundle > /dev/null 2>&1 
# if [ $? == 0 ]; then
#   echo "WARNING: Bundler required.\n" + \
#        "Please run 'gem install bundler && /opt/redmine/bundle exec rake generate_secret_token'" + \
#        " before starting the application"
# else
#   runuser -l redmine -c 'bundle exec rake generate_secret_token'
# fi
# popd

