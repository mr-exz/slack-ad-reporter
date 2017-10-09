#!/usr/bin/env bash

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm reload
rvm requirements run
rvm install 2.3.4
rvm use 2.3.4 --default

gem install net-ldap
gem install mail
gem install slack-ruby-client