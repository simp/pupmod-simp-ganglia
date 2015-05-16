# == Class: ganlia::monitor::udp_recv_channel
#
# Configures a udp_recv_channel section of /etc/ganglia/gmond.conf
# See gmond.conf(5) for more information
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::udp_recv_channel {
  $fragdir = fragmentdir('gmond')
  concat_build { 'gmond_udp_recv':
    target       => "$fragdir/udp_recv_channel.conf",
    parent_build => 'gmond'
  }
}
