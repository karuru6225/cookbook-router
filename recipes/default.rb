#
# Cookbook Name:: cookbook-router
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'iptables::router'

settings = Chef::EncryptedDataBagItem.load('router', 'settings') ||
           node['router']

# network device settings
package 'bridge-utils' do
  action :install
end

template '/etc/network/interfaces' do
  source 'interfaces.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    lan_if: settings['lan_if'],
    wan_if: settings['wan_if'],
    network: settings['network'],
    router_ip: settings['router_ip'],
    netmask: settings['netmask']
  )
end

if node['platform'] == 'ubuntu'
  cookbook_file '/etc/init/failsafe.conf' do
    source 'failsafe.conf'
    owner 'root'
    group 'root'
    mode 00644
  end
end

# dns/dhcp settgins
package 'dnsmasq' do
  action :install
end

service 'dnsmasq' do
  action [:enable]
end

template '/etc/hosts' do
  source 'hosts.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    domain: settings['domain'],
    network: settings['network'],
    hosts: settings['hosts']
  )
  notifies :restart, 'service[dnsmasq]', :delayed
end

template '/etc/dnsmasq.conf' do
  source 'dnsmasq.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    domain: settings['domain'],
    network: settings['network'],
    router_ip: settings['router_ip'],
    netmask: settings['netmask'],
    range_start: settings['range_start'],
    range_end: settings['range_end'],
    hosts: settings['hosts']
  )
  notifies :restart, 'service[dnsmasq]', :delayed
end
