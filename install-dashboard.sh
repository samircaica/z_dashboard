#!/bin/bash

set -eu

cat >> ~/.bash_profile <<'END'
export RBENV_ROOT="/opt/perfcenter/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
END

export RBENV_ROOT="/opt/perfcenter/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

cd /opt/perfcenter/dashboard
bundle update rdoc
bundle install --deployment --full-index
chown -R perfcenter:perfcenter /opt/perfcenter/dashboard/
bundle exec rake assets:precompile RAILS_ENV=production RAILS_RELATIVE_URL_ROOT=/dashboard

passenger-install-apache2-module --snippet > /opt/perfcenter/httpd-config/passenger.conf