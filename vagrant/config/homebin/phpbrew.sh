#!/bin/bash

VERSION=5.3.29
FILE=/home/vagrant/.phpbrew/php/php-$VERSION/etc/php.ini
phpbrew install $VERSION +default+mysql

if grep -q "/var/run/mysqld/mysqld.sock" "$FILE"; then
  echo "Already have mysqli.default_socket defined"
else
  echo "mysqli.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
  echo "mysql.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
fi

VERSION=5.4.36
FILE=/home/vagrant/.phpbrew/php/php-$VERSION/etc/php.ini
phpbrew install $VERSION +default+mysql

if grep -q "/var/run/mysqld/mysqld.sock" "$FILE"; then
  echo "Already have mysqli.default_socket defined"
else
  echo "mysqli.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
  echo "mysql.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
fi

VERSION=5.5.20
FILE=/home/vagrant/.phpbrew/php/php-$VERSION/etc/php.ini
phpbrew install $VERSION +default+mysql

if grep -q "/var/run/mysqld/mysqld.sock" "$FILE"; then
  echo "Already have mysqli.default_socket defined"
else
  echo "mysqli.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
  echo "mysql.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
fi

VERSION=5.6.4
FILE=/home/vagrant/.phpbrew/php/php-$VERSION/etc/php.ini
phpbrew install $VERSION +default+mysql

if grep -q "/var/run/mysqld/mysqld.sock" "$FILE"; then
  echo "Already have mysqli.default_socket defined"
else
  echo "mysqli.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
  echo "mysql.default_socket = /var/run/mysqld/mysqld.sock" >> $FILE
fi

