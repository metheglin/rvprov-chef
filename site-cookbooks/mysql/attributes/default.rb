##
## Install Settings
##

# Version
default['mysql']['version_serial'] = "5.6.17"
default['mysql']['version'] = "mysql-#{default['mysql']['version_serial']}"

# Directory
default['mysql']['symbolic'] = "/usr/local/mysql"
default['mysql']['dir']     = "/usr/local/mysql-#{default['mysql']['version_serial']}/"
default['mysql']['src_dir'] = "/usr/local/src/"

# User
default['mysql']['install_user']  = "root"
default['mysql']['install_group'] = "root"


##
## Conf Settings
##

# General

# User
default['mysql']['user']         = "mysql"
default['mysql']['group']        = "mysql"
default['mysql']['user_password'] = "temporary_password"

default['mysql']['log_dir'] = "/var/log/mysqld/"
default['mysql']['conf_name'] = "my.cnf"
default['mysql']['conf'] = {}
default['mysql']['conf'] = {
  'mysqld' => {
    'datadir' => "#{default['mysql']['symbolic']}/data",
    'user' => 'mysql',
    'socket' => "#{default['mysql']['symbolic']}/data/mysql.sock",
    'symbolic-links' => 0,
    'character-set-server' => 'utf8',
    'log-error' => "#{default['mysql']['log_dir']}error.log",
    'slow_query_log' => 'ON',
    'slow_query_log_file' => "#{default['mysql']['log_dir']}/slow.log",
    'long_query_time' => '1'
  },
  'mysqld_safe' => {
    'log-error' => "#{default['mysql']['log_dir']}error.log",
    'pid-file' => "#{default['mysql']['symbolic']}/data/mysqld.pid"
  },
  'mysql' => {
    'default-character-set' => 'utf8',
    'socket' => "#{default['mysql']['symbolic']}/data/mysql.sock"
  }
}

