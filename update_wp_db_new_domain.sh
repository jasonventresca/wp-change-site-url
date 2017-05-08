#!/usr/bin/env bash

### Update the site URL of your Wordpress MySQL database.

### If you're like me and started your wordpress site on localhost,
### this tool is useful when it's time to port your site to a new server.

### Adapted from the `Changing the URL directly in the database`
### section of https://codex.wordpress.org/Changing_The_Site_URL

set -eu

db_name=$1
new_domain=$2

SQL_FILTER="where option_name in ('siteurl', 'home')"

echo "Rows before:"
echo "select * from wp_options $SQL_FILTER" | mysql -t $db_name

echo "Running update now."
echo "update wp_options set option_value = 'http://${new_domain}' $SQL_FILTER" | mysql $db_name

echo "Rows after:"
echo "select * from wp_options $SQL_FILTER" | mysql -t $db_name
