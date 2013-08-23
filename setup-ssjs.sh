#!/bin/bash
# Install node packages
#npm install

#echo -e "\n\nNOW ENTER YOUR HEROKU PASSWORD"
# Set up heroku.
# - devcenter.heroku.com/articles/config-vars
# - devcenter.heroku.com/articles/heroku-postgresql
#heroku login
#heroku create
#ssh-keygen -t rsa
#heroku keys:add
#heroku addons:add heroku-postgresql:dev --app michaelklopf-bitstarter-mooc
#heroku addons:add heroku-postgresql:dev --app michaelklopf-bitstarter-s-mooc
#heroku config --app michaelklopf-bitstarter-mooc | grep HEROKU_POSTGRESQL_BRONZE_URL
#heroku config --app michaelklopf-bitstarter-s-mooc | grep HEROKU_POSTGRESQL*
#working is:
#heroku pg:promote --app michaelklopf-bitstarter-mooc HEROKU_POSTGRESQL_BRONZE_URL
#heroku pg:promote --app michaelklopf-bitstarter-s-mooc HEROKU_POSTGRESQL_WHITE_URL

heroku pg:promote "heroku config --app michaelklopf-bitstarter-mooc  | grep HEROKU_POSTGRESQL_BRONZE_URL | cut -f1 -d':'" 
#heroku pg:promote 'heroku config  | grep HEROKU_POSTGRESQL_WHITE | cut -f1 -d':'' --app michaelklopf-bitstarter-s-mooc
heroku plugins:install git://github.com/ddollar/heroku-config.git

#check config with
#heroku config --app michaelklopf-bitstarter-mooc
#heroku config --app michaelklopf-bitstarter-s-mooc

#see database information
#heroku pg:info --app michaelklopf-bitstarter-mooc
#heroku pg:info --app michaelklopf-bitstarter-s-mooc

#connect to db
#heroku pg:psql --app michaelklopf-bitstarter-mooc
# quit connection with \q

#more info
# https://devcenter.heroku.com/articles/heroku-postgresql

# Set up heroku configuration variables
# https://devcenter.heroku.com/articles/config-vars
# - Edit .env to include your own COINBASE_API_KEY and HEROKU_POSTGRES_URL.
# - Modify the .env.dummy file, and DO NOT check .env into the git repository.
# - See .env.dummy for details.
cp .env.dummy .env

# For local: setup postgres (one-time) and then run the local server
./pgsetup.sh

STRING=$( cat <<EOF
Great. You've now set up local and remote postgres databases for your
app to talk to.\n\n

Now do the following:\n\n

1) Get your API key from coinbase.com/account/integrations\n\n
2) Paste it into the .env file.\n\n
3) To run the server locally, do:\n
     $ foreman start\n
   Then check your EC2 URL, e.g. ec2-54-213-131-228.us-west-2.compute.amazonaws.com:8080 \n
   Try placing some orders and then clicking '/orders' at the top.\n\n
4) To deploy to heroku\n
     $ git push heroku master\n
     $ heroku config:push\n
   Then check the corresponding Heroku URL\n\n
   Try placing some orders and then clicking '/orders' at the top.\n
EOF
)
echo -e $STRING
