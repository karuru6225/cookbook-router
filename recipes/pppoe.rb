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

cookbook_file '/etc/ppp/ip-up.d/0clampmss' do
  source '0clampmss_ip-up'
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/etc/ppp/ip-down.d/0clampmss' do
  source '0clampmss_ip-down'
  owner 'root'
  group 'root'
  mode 00755
end

template '/etc/ppp/chap-secrets' do
  source 'chap-secrets.erb'
  owner 'root'
  group 'root'
  mode 00600
  variables(
    user: settings['pppoe_user'],
    pass: settings['pppoe_pass']
  )
end

template '/etc/ppp/pap-secrets' do
  source 'pap-secrets.erb'
  owner 'root'
  group 'root'
  mode 00600
  variables(
    user: settings['pppoe_user'],
    pass: settings['pppoe_pass']
  )
end

template '/etc/ppp/peers/dsl-provider' do
  source 'dsl-provider.erb'
  owner 'root'
  group 'root'
  mode 00640
  variables(
    user: settings['pppoe_user'],
    iface: settings['pppoe_iface']
  )
end
