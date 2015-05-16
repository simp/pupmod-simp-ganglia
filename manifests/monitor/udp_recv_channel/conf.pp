# == Define: ganglia::monitor::udp_recv_channel::conf
#
# Configures a udp_recv_channel section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*udp_recv_mcast_join*]
# [*udp_recv_bind*]
# [*udp_recv_port*]
# [*udp_recv_mcast_if*]
# [*udp_recv_family*]
# [*allow_networks*]
#   Client networks to allow access to this port. Set to 'any' to allow all
#   networks. If the value is not 'any', an acl will be added with access for
#   the specified networks
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::udp_recv_channel::conf (
  $udp_recv_mcast_join = '',
  $udp_recv_bind = '',
  $udp_recv_port = '',
  $udp_recv_mcast_if = '',
  $udp_recv_family = '',
  $allow_networks = hiera_array('client_nets', ['127.0.0.1', '::1'])
) {
  include 'ganglia::monitor::udp_recv_channel'

  concat_fragment { "gmond_udp_recv+${name}_0_begin":
    content => 'udp_recv_channel {
'
  }
  concat_fragment { "gmond_udp_recv+${name}_9_end":
    content => '}
'
  }
  concat_fragment { "gmond_udp_recv+${name}_1_conf":
    content => template('ganglia/gmond/udp_recv_channel.erb')
  }

  if $allow_networks != 'any' {
    ganglia::monitor::udp_recv_channel::add_acl{ "${name}_acl":
      udp_recv_name => $name
    }

    ganglia::monitor::udp_recv_channel::add_acl_access { 'nets':
      udp_recv_name => $name,
      udp_recv_port => $udp_recv_port,
      access_cidrs  => nets2cidr($allow_networks),
      access_action => 'allow'
    }
  }
  else {
    iptables::add_udp_listen { "allow_all_gmond_$name":
      order       => '11',
      client_nets => $allow_networks,
      dports      => $udp_recv_port
    }
  }
}
