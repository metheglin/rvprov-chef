#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

## Make /var/log/nginx

## nginx
configure_option = node['nginx']['configure'].join(" ")
bash "install nginx" do
  user     node['nginx']['install_user']
  cwd      node['nginx']['src_dir']
  not_if   "ls #{node['nginx']['dir']}"
  notifies :run, 'bash[start nginx]', :immediately
  code   <<-EOH
    wget "#{node['nginx']['download_url']}"
    tar xzf #{node['nginx']['version']}.tar.gz
    
    cd #{node['nginx']['version']}
    ./configure #{configure_option}
    make
    make install
  EOH
end

## Create conf/conf.d
bash "create conf.d" do
  user     node['nginx']['install_user']
  cwd      node['nginx']['src_dir']
  not_if   "ls #{node['nginx']['symbolic']}"
  code   <<-EOH
    mkdir -p #{node['nginx']['dir']}/conf/conf.d
  EOH
end

## Create SymLink
bash "create symlink" do
  user     node['nginx']['install_user']
  cwd      node['nginx']['src_dir']
  not_if   "ls #{node['nginx']['symbolic']}"
  code   <<-EOH
    ln -s #{node['nginx']['dir']} #{node['nginx']['symbolic']}
  EOH
end

## Create /var/log/nginx
bash "create log dir" do
  user     node['nginx']['install_user']
  cwd      node['nginx']['src_dir']
  not_if   "ls #{node['nginx']['symbolic']}"
  code   <<-EOH
    mkdir -p #{node['nginx']['log_dir']}
    chown #{node['nginx']['user']}:#{node['nginx']['group']} #{node['nginx']['log_dir']}
    chmod g+w #{node['nginx']['log_dir']}
  EOH
end

## Update nginx.conf
template "#{node['nginx']['dir']}conf/nginx.conf" do
  source "nginx.conf.erb"
  owner node['nginx']['install_user']
  group node['nginx']['install_group']
  mode 00644
  #notifies :run, 'bash[restart nginx]', :immediately
end

#for include_file in node['nginx']['include_files']
#  template "#{node['nginx']['dir']}conf/extra/#{include_file}.conf" do
#    source   "#{include_file}.conf.erb"
#    owner    node['nginx']['install_user']
#    group    node['nginx']['install_group']
#    mode     00644
#    #notifies :run, 'bash[restart nginx]', :immediately
#  end
#end

bash "start nginx" do
  action :nothing
  flags  '-ex'
  user   node['nginx']['install_user']
  code   <<-EOH
    #{node['nginx']['dir']}sbin/nginx
  EOH
end

bash "restart nginx" do
  action :nothing
  flags  '-ex'
  user   node['nginx']['install_user']
  code   <<-EOH
    #{node['nginx']['dir']}sbin/nginx -s quit
    #{node['nginx']['dir']}sbin/nginx
  EOH
end
