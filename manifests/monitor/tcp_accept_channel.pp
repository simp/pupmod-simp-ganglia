# == Class: ganglia::monitor::tcp_accept_channel
#
# Configures a tcp_accept_channel section of /etc/ganglia/gmond.conf
# See gmond.conf(5) for more information
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::tcp_accept_channel {
  $fragdir = simpcat_fragmentdir('gmond')
  simpcat_build { 'gmond_tcp_accept':
    target       => "$fragdir/tcp_accept_channel.conf",
    parent_build => 'gmond'
  }
}
