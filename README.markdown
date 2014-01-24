# Step to compile and package redmine ready to be FPMed.

## Install Requirements
sudo yum install ruby-1.9.3\_p484\_x86\_64.rpm
sudo gem install bundler
sudo gem install fpm

## Download, compile and package
./package.sh
