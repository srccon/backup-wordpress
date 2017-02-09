#!/bin/bash

# wp-backup.sh
#
# a quick script to make a backup of wordpress, if run twice, it will override the previous backup

# What do you want to name the site?
SITENAME=''

# Where is the webserver webroot, usually /var/www/html on Ubuntu/Debian
WEBROOT='/var/www/html'

# change if your WP install is in a subdirectory
WPDBCONFIG="$WEBROOT/wp-config.php"

# Where do you want the backups to go
BAKDIR="$HOME/Backup-Wordpress"


### LOGIC

# Check if the backup directory exists, error if not
if [ ! -d "$BAKDIR" ]; then
  echo "ERROR: The directory $BAKDIR does not exist please"
  echo "       run the following to create the directory"
  echo "       mkdir -p $BAKDIR"
  echo '       or change the $BAKDIR variable'
  exit 1
fi

# Check if the wp-config.php file exists, error if not
if [ ! -f $WPDBCONFIG ]; then
  echo "ERROR: Cannot find wp-config.php at $WPDCONFIG"
  echo '       Is the $WEBROOT variable set to the root of your WP install?'
  exit 1
fi

# Add default sitename if no sitename
if [ -z $SITENAME ]; then
  SITENAME='Backup-Wordpress'
fi

# Pulls DB credentials from the wp-config.php WP file
WPDBNAME="$(cat $WPDBCONFIG | grep DB_NAME | cut -d \' -f 4)"
WPDBUSER="$(cat $WPDBCONFIG | grep DB_USER | cut -d \' -f 4)"
WPDBPASS="$(cat $WPDBCONFIG | grep DB_PASSWORD | cut -d \' -f 4)"
WPDBHOST="$(cat $WPDBCONFIG | grep DB_HOST | cut -d \' -f 4)"

# creates tarball of WP filesystem and exports compressed database
tar -czf "$BAKDIR/$SITENAME.tar.gz" $WEBROOT
mysqldump -h $WPDBHOST -u $WPDBUSER -p$WPDBPASS $WPDBNAME | gzip -c > "$BAKDIR/$SITENAME.sql.gz"
exit 0
