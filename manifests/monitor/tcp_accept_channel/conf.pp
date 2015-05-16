# == Define: ganglia::monitor::tcp_accept_channel::conf
#
# Configures a tcp_accept_channel section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*tcp_accept_bind*]
# [*tcp_accept_port*]
# [*tcp_accept_interface*]
# [*tcp_accept_family*]
# [*tcp_accept_timeout*]
# [*allow_networks*]
#   Client networks to allow access to this port. Set to 'any' to allow all
#   networks. If the value is not 'any', an acl will be added with access for
#   the specified networks
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::tcp_accept_channel::conf (
  $tcp_accept_bind = '',
  $tcp_accept_port = '',
  $tcp_accept_interface = '',
  $tcp_accept_family = '',
  $tcp_accept_timeout = '',
  $allow_networks = hiera('client_nets')
) {
  include 'ganglia::monitor::tcp_accept_channel'

  concat_fragment { "gmond_tcp_accept+${name}_0_begin":
    content => 'tcp_accept_channel {
'
  }
  concat_fragment { "gmond_tcp_accept+${name}_9_end":
    content => '}
'
  }
  concat_fragment { "gmond_tcp_accept+${name}_1_conf":
    content => template('ganglia/gmond/tcp_accept_channel.erb')
  }

  if $allow_networks != 'any' {
    ganglia::monitor::tcp_accept_channel::add_acl{ "${name}_acl":
      tcp_accept_name => $name
    }

    ganglia::monitor::tcp_accept_channel::add_acl_access { 'nets':
      tcp_accept_name => $name,
      tcp_accept_port => $tcp_accept_port,
      access_cidrs    => nets2cidr($allow_networks),
      access_action   => 'allow'
    }
  }
  else {
    iptables::add_tcp_stateful_listen { "allow_all_gmond_$name":
      order       => '11',
      client_nets => $allow_networks,
      dports      => $tcp_accept_port
    }
  }
}
