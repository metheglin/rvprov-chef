###
# Install Settings
###

# Version
default['nginx']['version_serial'] = "1.6.0"
default['nginx']['version'] = "nginx-#{default['nginx']['version_serial']}"
default['nginx']['download_url'] = "http://file.agile.reivo.co.jp/middlewares/#{default['nginx']['version']}.tar.gz"

# Directory
default['nginx']['symbolic'] = "/usr/local/nginx"
default['nginx']['dir']     = "/usr/local/#{default['nginx']['version']}/"
default['nginx']['src_dir'] = "/usr/local/src/"

# User
default['nginx']['install_user']  = "root"
default['nginx']['install_group'] = "root"

# Configure Options
default['nginx']['configure']  = %W{
  --prefix=#{default['nginx']['dir']}
  --with-http_ssl_module
  --with-http_gzip_static_module
  --with-http_realip_module
  --with-http_stub_status_module
  --with-ipv6
  --error-log-path=/var/log/nginx/error.log
  --http-log-path=/var/log/nginx/access.log
}

# Include files
default['nginx']['include_files']  = []


###
# Conf Settings
###

# General
default['nginx']['port']            = 80
default['nginx']['port_ssl']        = 443
default['nginx']['directory_index'] = "index.php, index.html"

# User
default['nginx']['user']         = "nginx"
default['nginx']['group']        = "nginx"
default['nginx']['server_admin'] = "you@example.com"

# Server
default['nginx']['server_name']   = "localhost"
default['nginx']['document_root'] = "#{default['nginx']['dir']}/html"

# Logs
default['nginx']['log_dir'] = '/var/log/nginx'
default['nginx']['access_log'] = "#{default['nginx']['log_dir']}/access_log"
default['nginx']['error_log']  = "#{default['nginx']['log_dir']}/error_log"

# Worker
default['nginx']['worker_processes'] = 1
default['nginx']['worker_connections'] = 1024
