#!/bin/bash
set -e
set -x

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="2.5.0"
REDMINE_VER="redmine-$VERSION"
REDMINE_GZ="$DIR/$REDMINE_VER.tar.gz"
REDMINE_DIR="$HOME/redmine"

# Install Requirements
# IMPORTANT: This script assumes ruby 1.9.3 is installed
command -v bundle > /dev/null 2>&1 || { echo 'bundler required'; exit 1; }
command -v fpm > /dev/null 2>&1 || { echo 'fpm required'; exit 1; }

yum list installed | grep ImageMagick-devel > /dev/null 2>&1 || sudo yum install -y ImageMagick-devel
yum list installed | grep mysql-devel > /dev/null 2>&1 || sudo yum install -y mysql-devel

# Download Redmine
[ ! -e "$REDMINE_GZ" ] && curl -O http://www.redmine.org/releases/$REDMINE_VER.tar.gz

[ ! -d "$REDMINE_DIR" ] && tar xf "$REDMINE_GZ" -C $HOME && mv $HOME/$REDMINE_VER $REDMINE_DIR

pushd "$REDMINE_DIR"
# Configure database.yml
sed 's/password\: \"\"/password\: \"Password@01\"/' <"config/database.yml.example" > "config/database.yml"

# Create Gemfile.local
[ ! -e "Gemfile.local" ] && echo 'gem "puma"' > "Gemfile.local"

# Make Dirs
mkdir -p tmp/pdf public/plugin_assets

# Bundle install & package
bundle install --path vendor --without development test postgresql
bundle package
popd

# To specfy pre-install script and post-install
fpm -s dir -t rpm -n redmine -v $VERSION \
-C $HOME \
-p redmine_VERSION_ARCH.rpm \
-d "ImageMagick" \
--prefix=/opt \
--before-install preinstall.sh \
--after-install postinstall.sh \
--verbose redmine
