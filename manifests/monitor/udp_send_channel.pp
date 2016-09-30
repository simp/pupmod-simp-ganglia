# == Define: ganglia::monitor::udp_send_channel
#
# Configure a udp_send_channel section for the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*udp_send_mcast_join*]
# [*udp_send_mcast_if*]
# [*udp_send_host*]
# [*udp_send_port*]
# [*udp_send_ttl*]
# [*udp_send_bind*]
# [*udp_send_bind_hostname*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::udp_send_channel (
  $udp_send_mcast_join = '',
  $udp_send_mcast_if = '',
  $udp_send_host = '',
  $udp_send_port = '',
  $udp_send_ttl = '',
  $udp_send_bind = '',
  $udp_send_bind_hostname = ''
) {
  include 'ganglia::monitor'

  simpcat_fragment { "gmond+${name}_udp_send_channel.conf":
    content => template('ganglia/gmond/udp_send_channel.erb')
  }
}
