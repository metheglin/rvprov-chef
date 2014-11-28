#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# They should be downloaded by wget because of too large to mange under the Git
# cookbook_file "#{node['ruby']['src_dir']}#{node['ruby']['version']}.tar.gz" do
#   mode 0644
# end

bash "install ruby" do
  user     node['ruby']['install_user']
  cwd      node['ruby']['src_dir']
  not_if   "ls #{node['ruby']['dir']}"
  code   <<-EOH
    wget "http://file.agile.reivo.co.jp/middlewares/#{node['ruby']['version']}.tar.gz"
    tar xzf #{node['ruby']['version']}.tar.gz
    cd #{node['ruby']['version']}
    ./configure --prefix=#{node['ruby']['dir']}
    make
    make install
  EOH
end

bash "teardown ruby" do
  user     node['ruby']['install_user']
  cwd      node['ruby']['src_dir']
  not_if   "ls #{node['ruby']['symbolic']}"
  code   <<-EOH
    ln -s #{node['ruby']['dir']} #{node['ruby']['symbolic']}
  EOH
end

bash "path setup" do
  user     node['ruby']['install_user']
  cwd      node['ruby']['src_dir']
  not_if   "ls /etc/profile.d/ruby.sh"
  code   <<-EOH
    echo "PATH=#{node['ruby']['symbolic']}/bin:$PATH" >> /etc/profile.d/ruby.sh
    echo "export PATH" >> /etc/profile.d/ruby.sh
  EOH
end
