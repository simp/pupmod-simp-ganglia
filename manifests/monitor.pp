# == Class: ganglia::monitor
#
# Configure gmond.
#
# This class, and the associated defines, should provide relatively
# comprehensive coverage of the gmond features.
#
# See gmond(1) and gmond.conf(5) for additional details.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor {
  include 'ganglia'
  include 'ganglia::monitor::collection_group'
  include 'ganglia::monitor::mods'
  include 'ganglia::monitor::tcp_accept_channel'
  include 'ganglia::monitor::udp_recv_channel'

  package { 'ganglia-gmond':
    ensure => 'latest'
  }

  if $::hardwaremodel == 'x86_64' {
    package { 'ganglia-gmond.i386':
      ensure => 'absent',
      notify => Package['ganglia-gmond']
    }
    package { 'libganglia.i386':
      ensure => 'absent',
      notify => Package['ganglia-gmond.i386']
    }
  }

  service { 'gmond':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['ganglia-gmond']
  }

  simpcat_build { 'gmond':
    order  => ['*.conf'],
    target => '/etc/ganglia/gmond.conf'
  }

  file { '/etc/ganglia/gmond.conf':
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
    audit     => content,
    subscribe => Simpcat_build['gmond'],
    notify    => Service['gmond']
  }
}
