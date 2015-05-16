# == Class: ganglia
#
# Configure Ganglia (gmond, gmetad, and web).
#
# This class, and the associated defines, should provide relatively
# comprehensive coverage of the ganglia features.
#
# See gmond(1), gmetad(1) and gmond.conf(5) for additional details.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia {
  file { '/etc/ganglia':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }
}
