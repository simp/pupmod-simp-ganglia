# == Class: ganglia::monitor::host
#
# Configures the host section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::host (
  $host_location = 'unspecified'
) {
  include 'ganglia::monitor'

  simpcat_fragment { 'gmond+host.conf':
    content => template('ganglia/gmond/host.erb')
  }
}
