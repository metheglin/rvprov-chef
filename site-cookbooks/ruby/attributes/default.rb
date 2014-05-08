##
## Install Settings
##

# Version
default['ruby']['version_serial'] = "2.1.1"
default['ruby']['version'] = "ruby-#{default['ruby']['version_serial']}"

# Directory
default['ruby']['symbolic'] = "/usr/local/ruby"
default['ruby']['dir']     = "/usr/local/ruby-#{default['ruby']['version_serial']}/"
default['ruby']['src_dir'] = "/usr/local/src/"

# User
default['ruby']['install_user']  = "root"
default['ruby']['install_group'] = "root"


##
## Conf Settings
##

# General

# User
default['ruby']['user']         = "ruby"
default['ruby']['group']        = "ruby"
default['ruby']['user_password'] = "temporary_password"

default['ruby']['log_dir'] = "/var/log/rubyd/"
default['ruby']['conf_name'] = "my.cnf"
default['ruby']['conf'] = {}
default['ruby']['conf'] = {
  'rubyd' => {
    'datadir' => "#{default['ruby']['symbolic']}/data",
    'user' => 'ruby',
    'socket' => "#{default['ruby']['symbolic']}/data/ruby.sock",
    'symbolic-links' => 0,
    'character-set-server' => 'utf8',
    'log-error' => "#{default['ruby']['log_dir']}error.log",
    'slow_query_log' => 'ON',
    'slow_query_log_file' => "#{default['ruby']['log_dir']}/slow.log",
    'long_query_time' => '1'
  },
  'rubyd_safe' => {
    'log-error' => "#{default['ruby']['log_dir']}error.log",
    'pid-file' => "#{default['ruby']['symbolic']}/data/rubyd.pid"
  },
  'ruby' => {
    'default-character-set' => 'utf8',
    'socket' => "#{default['ruby']['symbolic']}/data/ruby.sock"
  }
}

