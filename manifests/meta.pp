# == Class: ganglia::meta
#
# Configure gmetad.
#
# This class, and the associated defines, should provide relatively
# comprehensive coverage of the gmetad features.
#
# See gmetad(1) for additional details.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::meta {
  include 'ganglia'

  package { 'ganglia-gmetad':
    ensure => 'latest'
  }

  # Some hackery to get rid of the i386 version if installed since we split up
  # the repos.
  if $::hardwaremodel == 'x86_64' {
    package { 'ganglia-gmetad.i386':
      ensure => 'absent',
      notify => Package['ganglia-gmetad']
    }
  }

  simpcat_build { 'gmetad':
    target  => '/etc/ganglia/gmetad.conf',
    order   => ['*.conf'],
    require => File['/etc/ganglia']
  }

  file { '/etc/ganglia/gmetad.conf':
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
    audit     => content,
    notify    => Service['gmetad'],
    subscribe => Simpcat_build['gmetad']
  }

  # Simply allow blanket IGMP...when you need it, you need it.
  iptables_rule { 'allow_igmp':
    content  => '-p igmp -j ACCEPT',
    apply_to => 'all'
  }

  service { 'gmetad':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['ganglia-gmetad']
  }
}
