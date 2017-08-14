#!/bin/bash

set -eu

git clone https://github.com/sstephenson/rbenv.git /opt/perfcenter/rbenv
git clone https://github.com/sstephenson/ruby-build.git /opt/perfcenter/rbenv/plugins/ruby-build

cat >> ~/.bash_profile <<'END'
export RBENV_ROOT="/opt/perfcenter/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
END

export RBENV_ROOT="/opt/perfcenter/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

rbenv install 2.3.1
rbenv global 2.3.1
gem install bundler
gem install passenger
gem install pg
rbenv rehash

passenger-install-apache2-module --auto --languages ruby,python

mkdir /opt/perfcenter/httpd-config