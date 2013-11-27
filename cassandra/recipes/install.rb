#
# Cookbook Name:: cassandra
# Recipe:: install
#
# Copyright 2013, RADKEVICH
#
# All rights reserved - Do Not Redistribute
#

# Create group
group "#{node[:cassandra][:group]}" do
  gid node[:cassandra][:gid]
end

# Create user
user "#{node[:cassandra][:user]}" do
  comment "Cassandra User"
  uid node[:cassandra][:uid]
  gid node[:cassandra][:gid]
  system true
  shell "/bin/sh"
end

file_name = node[:cassandra][:remote_url].split('/')[-1]
app_dir_name = file_name.split(/(.tar|.zip)/)[0]
app_dir_name = app_dir_name.split("-bin")[0]

remote_file "#{Chef::Config[:file_cache_path]}/#{file_name}" do
  source "#{node[:cassandra][:remote_url]}"
  action :create_if_missing
end

# Extract downloaded file
execute "extract cassandra" do
  command "tar -xpf #{Chef::Config[:file_cache_path]}/#{file_name} -C #{Chef::Config[:file_cache_path]}"
  action :run
end

# Move extracted files to the home folder
execute "move cassandra" do
  command "mv #{Chef::Config[:file_cache_path]}/#{app_dir_name} #{node[:cassandra][:home_dir]}"
  not_if {File.directory?("#{node[:cassandra][:home_dir]}")}
  action :run
end

mx4j_file_name = "mx4j-#{node[:cassandra][:mx4j_version]}.tar.gz"
mx4j_app_dir_name = mx4j_file_name.split(/(.tar.gz|.zip)/)[0]

# Download mx4j
#remote_file "#{Chef::Config[:file_cache_path]}/#{mx4j_file_name}" do
#  source "#{node[:cassandra][:mx4j_release_url]}"
#  action :create_if_missing
#end

# Extract downloaded file
#execute "extract mx4j" do
#  command "tar -xzf #{Chef::Config[:file_cache_path]}/#{mx4j_file_name} -C #{Chef::Config[:file_cache_path]}"
#  action :run
#end

# Copy mx4j-tools.jar
#execute "copy mx4j-tools" do
#  command "cp #{Chef::Config[:file_cache_path]}/#{mx4j_app_dir_name}/lib/mx4j-tools.jar #{node[:cassandra][:home_dir]}/lib/mx4j-tools.jar"
#  not_if {File.exists?("#{node[:cassandra][:home_dir]}/lib/mx4j-tools.jar")}
#  action :run
#end

# Fix owner and group
execute "fix owner" do
  command "chown -R #{node[:cassandra][:user]}:#{node[:cassandra][:group]} #{node[:cassandra][:home_dir]}"
  action :run
end

# Make bin folder runnable
execute "fix owner" do
  command "chmod +x #{node[:cassandra][:home_dir]}/bin"
  action :run
end

# Create directories
[
  node[:cassandra][:log_dir],
  node[:cassandra][:lib_dir],
  node[:cassandra][:pid_dir],
  node[:cassandra][:commitlog_dir],
  node[:cassandra][:saved_caches_dir]
].each do |dir|
  directory dir do
    mode 0755
    owner node[:cassandra][:user]
    group node[:cassandra][:group]
    recursive true
    action :create
  end
end

node[:cassandra][:data_dirs].each do |dir|
  directory dir do
    mode 0755
    owner node[:cassandra][:user]
    group node[:cassandra][:group]
    recursive true
    action :create
  end
end

# Create service
template "/etc/init.d/cassandra" do
  source "cassandra.erb"
  mode 0755
end

# Cassandra.yaml config file
template File.join(node[:cassandra][:home_dir], "conf/cassandra.yaml") do
  source "cassandra.yaml.erb"
  mode 0755
  owner node[:cassandra][:user]
  group node[:cassandra][:group]
end

# Log4j config file
template File.join(node[:cassandra][:home_dir], "conf/log4j-server.properties") do
  source "log4j-server.properties.erb"
  mode 0755
  owner node[:cassandra][:user]
  group node[:cassandra][:group]
end

node.set[:cassandra][:installed] = true
