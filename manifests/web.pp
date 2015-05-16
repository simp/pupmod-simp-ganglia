# == Class: ganglia::web
#
# Configure ganglia PHP web front-end.
#
# This class, and the associated defines, should provide relatively
# comprehensive coverage of the ganglia PHP web front-end features.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::web {
  include 'ganglia'

  $base = '/var/www/html/ganglia'
  $valid_acls = ['GUEST','ADMIN']
  $valid_permissions = ['VIEW','EDIT']

  package { 'ganglia-web':
    ensure => 'absent',
    notify => Package['gweb']
  }

  package { 'gweb': ensure => latest }
  package { 'php': ensure => latest }
}
