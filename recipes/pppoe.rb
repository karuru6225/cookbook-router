#
# Cookbook Name:: cookbook-router
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

settings = Chef::EncryptedDataBagItem.load('router', 'settings') ||
           node['router']

# pppoe setting
package 'pppoe' do
  action :install
end
