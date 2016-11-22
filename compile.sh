#!/bin/bash

set -e

apt-get -y update
apt-get -y install redis-server postgresql postgresql-contrib

redis-server &
pid=$!

/etc/init.d/postgresql start

su postgres << EOF
createdb discourse
psql -c "create user root with superuser;"
psql -c "grant all privileges on database discourse to root;"
psql -d discourse -c "alter schema public owner to root;"
psql -c "update pg_database set encoding = pg_char_to_encoding('UTF8') where datname = 'discourse';"
EOF

export RAILS_ENV=production

sed -i -e 's/db_username = discourse/db_username = root/g' discourse/config/discourse_defaults.conf

pushd discourse
  bundle install
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake assets:precompile
popd

cp -r discourse/* discourse-compiled

kill "${pid}"
