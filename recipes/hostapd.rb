#
# Cookbook Name:: router
# Recipe:: hostapd
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'hostapd' do
  action :install
end

service 'hostapd' do
  action [:enable]
end

settings = Chef::EncryptedDataBagItem.load('router', 'settings') ||
           node['router']

template '/etc/hostapd/hostapd.conf' do
  source 'hostapd.conf.erb'
  owner 'root'
  group 'root'
  mode 00600
  variables(
    mode: settings['mode'],
    ht_capab: settings['ht_capab'],
    ssid: settings['ssid'],
    pass: settings['pass']
  )
  notifies :restart, 'service[hostapd]', :delayed
end

cookbook_file '/etc/default/hostapd' do
  source 'hostapd'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[hostapd]', :delayed
end
