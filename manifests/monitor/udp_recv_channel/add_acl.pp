# == Define: ganglia::monitor::udp_recv_channel::add_acl
#
# Adds an ACL to a udp_recv_channel section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*udp_recv_name*]
#   Must be set to the value used as $name in udp_recv_channel::conf
#
# [*acl_default*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::udp_recv_channel::add_acl(
  $udp_recv_name,
  $acl_default = 'deny'
) {
  include 'ganglia::monitor::udp_recv_channel'

  simpcat_fragment { "gmond_udp_recv+${udp_recv_name}_4_acl_begin":
    content => "  acl {
    default = \"$acl_default\"
"
  }
  simpcat_fragment { "gmond_udp_recv+${udp_recv_name}_6_acl_end":
    content => '  }
'
  }
}
