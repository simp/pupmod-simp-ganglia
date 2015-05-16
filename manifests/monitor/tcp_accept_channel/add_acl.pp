# == Define: ganglia::monitor::tcp_accept_channel::add_acl
#
# Adds an ACL tcp_accept_channel section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*tcp_accept_name*]
#   Must be set to the value used as $name in tcp_accept_channel::conf
#
# [*acl_default*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::tcp_accept_channel::add_acl(
  $tcp_accept_name,
  $acl_default = 'deny'
) {
  include 'ganglia::monitor::tcp_accept_channel'

  concat_fragment { "gmond_tcp_accept+${tcp_accept_name}_4_acl_begin":
    content => "  acl {
    default = \"$acl_default\"
"
  }
  concat_fragment { "gmond_tcp_accept+${tcp_accept_name}_6_acl_end":
    content => '  }
'
  }
}
