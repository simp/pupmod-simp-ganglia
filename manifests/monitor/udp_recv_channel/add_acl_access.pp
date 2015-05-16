# == Define: ganglia::monitor::udp_recv_channel::add_acl_access
#
# Adds an access section to the acl in a udp_recv_channel section of the
# gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*udp_recv_name*]
#   Must be set to the value used as $name in udp_recv_channel::conf
#
# [*udp_recv_port*]
# [*access_action*]
# [*access_ip*]
# [*access_mask*]
# [*access_cidrs*]
#   An array of nets to allow / deny in cidr notation
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::udp_recv_channel::add_acl_access(
  $udp_recv_name,
  $udp_recv_port,
  $access_action,
  $access_ip = '',
  $access_mask = '',
  $access_cidrs = []
) {
  include 'ganglia::monitor::udp_recv_channel'

  if array_size($access_cidrs) != '0' {
    $l_access_cidrs = nets2cidr($access_cidrs)

    $access_file_name = inline_template('<%= "#{@l_access_cidrs.join("_").gsub("/", "_")}.access" %>')

    iptables::add_udp_listen { "allow_gmond_udp_${name}":
      order       => '11',
      client_nets => $l_access_cidrs,
      dports      => $udp_recv_port
    }
  }
  else {
    $access_file_name = "${access_ip}_${access_mask}_${access_action}.access"

    iptables::add_udp_listen { "allow_gmond_udp_${name}":
      order       => '11',
      client_nets => "${access_ip}/${access_mask}",
      dports      => $udp_recv_port
    }
  }
  concat_fragment { "gmond_udp_recv+${udp_recv_name}_5_${access_file_name}":
    content => template('ganglia/gmond/acl_access.erb')
  }

  if empty($access_ip) and empty($access_mask) {
    validate_net_list($access_cidrs)
  }
  else {
    validate_ipv4_address($access_ip)
    validate_between($access_mask,0,32)
  }

}
