##
## Install Settings
##

# Configure
default['passenger-apache']['apx2_path'] = "#{default['apache']['symbolic']}/bin/apxs"
default['passenger-apache']['apr_path'] = "#{default['apache']['symbolic']}/bin/apr-1-config"

# User
default['passenger-apache']['install_user']  = "root"
default['passenger-apache']['install_group'] = "root"

