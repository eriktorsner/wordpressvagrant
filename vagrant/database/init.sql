# We include default installations of WordPress with this Vagrant setup.
# In order for that to respond properly, default databases should be
# available for use.
CREATE DATABASE IF NOT EXISTS `wordpress`;
GRANT ALL PRIVILEGES ON `wordpress`.* TO 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';

CREATE DATABASE IF NOT EXISTS `wordpress-test`;
GRANT ALL PRIVILEGES ON `wordpress-test`.* TO 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';


