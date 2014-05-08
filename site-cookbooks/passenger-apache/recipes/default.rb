#
# Cookbook Name:: passenger-apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

gem_package "bundler" do
  options("--no-ri --no-rdoc")
end

gem_package "passenger" do
  options("--no-ri --no-rdoc")
end

bash "passenger-apache install" do
  user     node['passenger-apache']['install_user']
  #not_if   "ls /etc/profile.d/passenger-apache.sh"
  code   <<-EOH
    passenger-install-apache2-module --auto --apxs2-path #{node['passenger-apache']['apx2_path']} --apr-config-path #{node['passenger-apache']['apr_path']}
  EOH
end
