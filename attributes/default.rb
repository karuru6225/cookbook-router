default['router']['lan_if'] = 'eth0'
default['router']['wan_if'] = 'eth1'
default['router']['domain'] = 'example.com'
default['router']['network'] = '192.168.0.'
default['router']['router_ip'] = '1'
default['router']['netmask'] = '255.255.255.0'
default['router']['range_start'] = '3'
default['router']['range_end'] = '254'
default['router']['hosts'] = {
  router: {
    ip: '1'
  },
  hosta: {
    ip: '2',
    mac: '01:23:45:67:89:AB'
  }
}
default['router']['wlan_mode'] = 'g'
default['router']['wlan_ht_capab'] = '[LDPC][HT40-][HT40+][SMPS-STATIC][GF][SHORT-GI-20][SHORT-GI-40][TX-STBC][RX-STBC123][DELAYED-BA][MAX-AMSDU-7935][DSSS_CCK-40][PSMP][LSIG-TXOP-PROT]'
default['router']['wlan_ssid'] = 'wlan-ssid'
default['router']['wlan_pass'] = 'tekitonapassword'
