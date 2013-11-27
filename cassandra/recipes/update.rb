#
# Cookbook Name:: cassandra
# Recipe:: update
#
# Copyright 2013, RADKEVICH
#
# All rights reserved - Do Not Redistribute
#
unless node[:ec2][:local_ipv4].nil?
  node.set[:cassandra][:listen_address] = node[:ec2][:local_ipv4]
end
unless node[:ec2][:public_ipv4].nil?
  node.set[:cassandra][:broadcast_address] = node[:ec2][:public_ipv4]
end

# Get JNI libs
remote_file "#{node[:cassandra][:home_dir]}/lib/jna-3.5.1.jar" do
  source "https://maven.java.net/content/repositories/releases/net/java/dev/jna/jna/3.5.1/jna-3.5.1.jar"
  owner node[:cassandra][:user]
  group node[:cassandra][:group]
  action :create_if_missing
end

remote_file "#{node[:cassandra][:home_dir]}/lib/platform-3.5.1.jar" do
  source "https://maven.java.net/content/repositories/releases/net/java/dev/jna/platform/3.5.1/platform-3.5.1.jar"
  owner node[:cassandra][:user]
  group node[:cassandra][:group]
  action :create_if_missing
end

# Cassandra.yaml config file
template File.join(node[:cassandra][:home_dir], "conf/cassandra.yaml") do
  source "cassandra.yaml.erb"
  mode 0755
  owner node[:cassandra][:user]
  group node[:cassandra][:group]
  notifies :restart, "service[cassandra]"
end

# Log4j config file
template File.join(node[:cassandra][:home_dir], "conf/log4j-server.properties") do
  source "log4j-server.properties.erb"
  mode 0755
  owner node[:cassandra][:user]
  group node[:cassandra][:group]
  notifies :restart, "service[cassandra]"
end

service "cassandra" do 
  service_name "cassandra"
  supports :status => true, :restart => true
  action [ :nothing]
end
