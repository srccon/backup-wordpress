# backup-wordpress
Bash script to quickly backup wordpress on a linux VPS server. If run twice, it will override the previous backup. It's good for a quick backup before an update. Automatically pulls the database information from the `wp-config.php` file, once properly configured.

## Configurations

If you want to specify a site name organize your back up files, make sure to put define a `SITENAME=''`. If you're not on a Ubuntu/Debian Server, or have altered server configurations, you might have to change the `WEBROOT='/var/www/html'` to the directory being served by your webserver where your WP is installed. Also if you are hosting wordpress from a subdirectory, like `/blog`.

Assign where you want the backups to go by changing the `BAKDIR="$HOME/Backup-Wordpress"` variable.

The output is 2 files a `.tar.gz` of the WP filesystem and a `.sql.gz` of the database.
