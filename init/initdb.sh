#!/bin/bash
set -e

echo """

------------------------------------------------------
|                                                    |
|         [*] Waiting for MySQL to start...          |
|                                                    |
------------------------------------------------------

"""

until mysql -u"root" -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
  echo "Waiting for MySQL..."
  sleep 5
done



echo """

------------------------------------------------------
|                                                    |
|         [*] Creating databases and users...        |
|                                                    |
------------------------------------------------------

"""

mysql -P3306 -u"root" -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS wordpress;
    CREATE DATABASE IF NOT EXISTS joomla;
    CREATE DATABASE IF NOT EXISTS typo3;
    CREATE DATABASE IF NOT EXISTS prestashop;
    CREATE DATABASE IF NOT EXISTS spip;
    GRANT ALL PRIVILEGES ON wordpress.* TO 'db_user'@'%';
    GRANT ALL PRIVILEGES ON joomla.* TO 'db_user'@'%';
    GRANT ALL PRIVILEGES ON typo3.* TO 'db_user'@'%';
    GRANT ALL PRIVILEGES ON prestashop.* TO 'db_user'@'%';
    GRANT ALL PRIVILEGES ON spip.* TO 'db_user'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo """

------------------------------------------------------
|                                                    |
|          [*] Databases and users created.          |
|                                                    |
------------------------------------------------------

"""