#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# They should be downloaded by wget because of too large to mange under the Git
# cookbook_file "#{node['mysql']['src_dir']}#{node['mysql']['version']}.tar.gz" do
#   mode 0644
# end

bash "install mysql" do
  user     node['mysql']['install_user']
  cwd      node['mysql']['src_dir']
  not_if   "ls #{node['mysql']['dir']}"
  #notifies :run, 'bash[start mysql]', :immediately
  code   <<-EOH
    wget "http://file.agile.reivo.co.jp/middlewares/#{node['mysql']['version']}.tar.gz"
    tar xzf #{node['mysql']['version']}.tar.gz
    mv #{node['mysql']['version']} #{node['mysql']['dir']}
  EOH
end

bash "teardown mysql" do
  user     node['mysql']['install_user']
  cwd      node['mysql']['src_dir']
  not_if   "ls #{node['mysql']['symbolic']}"
  code   <<-EOH
    ln -s #{node['mysql']['dir']} #{node['mysql']['symbolic']}
  EOH
end

bash "user mysql" do
  user     node['mysql']['install_user']
  cwd      node['mysql']['src_dir']
  not_if   "id #{node['mysql']['user']}"
  code   <<-EOH
    groupadd #{node['mysql']['group']}
    useradd -m mysql -g #{node['mysql']['user']} -d #{node['mysql']['symbolic']}/data
    echo "#{node['mysql']['user_password']}" | passwd --stdin #{node['mysql']['user']}
  EOH
end

bash "initial setup" do
  user     node['mysql']['install_user']
  cwd      node['mysql']['src_dir']
  not_if   "ls -l #{node['mysql']['symbolic']}/data/mysql"
  code   <<-EOH
    cd #{node['mysql']['symbolic']}
    #{node['mysql']['symbolic']}/scripts/mysql_install_db --user=#{node['mysql']['user']} --basedir=#{node['mysql']['symbolic']} --datadir=#{node['mysql']['symbolic']}/data
  EOH
end
  

template "#{node['mysql']['conf_name']}" do
  source "my.cnf.erb"
  owner node['mysql']['install_user']
  group node['mysql']['install_group']
  mode 00644
end

bash "path setup" do
  user     node['mysql']['install_user']
  cwd      node['mysql']['src_dir']
  not_if   "ls -l /etc/profile.d/mysql.sh"
  code   <<-EOH
    echo "PATH=$PATH:#{node['mysql']['symbolic']}/bin" >> /etc/profile.d/mysql.sh
    echo "export PATH" >> /etc/profile.d/mysql.sh
  EOH
end

bash "chkconfig setup" do
  user     node['mysql']['install_user']
  cwd      node['mysql']['src_dir']
  not_if   "ls -l /etc/init.d/mysqld"
  code   <<-EOH
    cp #{node['mysql']['symbolic']}/support-files/mysql.server /etc/init.d/mysqld
    /sbin/chkconfig mysqld on
  EOH
end

#template "#{node['mysql']['dir']}conf/httpd.conf" do
#  source   "httpd.conf.erb"
#  owner    node['mysql']['install_user']
#  group    node['mysql']['install_group']
#  mode     00644
#  notifies :run, 'bash[restart mysql]', :immediately
#end
#
#bash "start mysql" do
#  action :nothing
#  flags  '-ex'
#  user   node['mysql']['install_user']
#  code   <<-EOH
#    #{node['mysql']['dir']}bin/mysqlctl start
#  EOH
#end
#
#bash "restart mysql" do
#  action :nothing
#  flags  '-ex'
#  user   node['mysql']['install_user']
#  code   <<-EOH
#    #{node['mysql']['dir']}bin/mysqlctl restart
#  EOH
#end
