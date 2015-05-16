# == Define: ganglia::monitor::tcp_accept_channel::add_acl_access
#
# Add an access to the acl in a tcp_accept_channel section of the gmond.conf
# file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*tcp_accept_name*]
#   Must be set to the value used as $name in tcp_accept_channel::conf
#
# [*tcp_accept_port*]
# [*access_action*]
# [*access_ip*]
# [*access_cidrs*]
#   An array of nets to allow / deny in cidr notation
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::tcp_accept_channel::add_acl_access(
  $tcp_accept_name,
  $tcp_accept_port,
  $access_action,
  $access_ip = '',
  $access_mask = '',
  $access_cidrs = []
) {
  include 'ganglia::monitor::tcp_accept_channel'

  if array_size($access_cidrs) != '0' {
    $l_access_cidrs = nets2cidr($access_cidrs)

    $access_file_name = inline_template('<%= "#{@l_access_cidrs.join("_").gsub("/", "_")}.access" %>')

    iptables::add_tcp_stateful_listen { "allow_gmond_$name":
      order       => '11',
      client_nets => $l_access_cidrs,
      dports      => $tcp_accept_port
    }
  }
  else {
    $access_file_name = "${access_ip}_${access_mask}_${access_action}.access"

    iptables::add_tcp_stateful_listen { "allow_gmond_$name":
      order       => '11',
      client_nets => "$access_ip/$access_mask",
      dports      => $tcp_accept_port
    }
  }
  concat_fragment { "gmond_tcp_accept+${tcp_accept_name}_5_$access_file_name":
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
