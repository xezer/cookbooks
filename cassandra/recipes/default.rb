#
# Cookbook Name:: cassandra
# Recipe:: default
#
# Copyright 2013, RADKEVICH
#
# All rights reserved - Do Not Redistribute
#

if !node[:cassandra][:installed]
  include_recipe "java"
  include_recipe "cassandra::install"
  
  service "cassandra" do 
    service_name "cassandra"
    supports :status => true, :restart => true
    action [ :enable, :start]
  end
else
  include_recipe "cassandra::update"
end
