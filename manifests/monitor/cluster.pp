# == Class: ganglia::monitor::cluster
#
# Configures the cluster section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*cluster_name*]
# [*cluster_owner*]
# [*cluster_latlong*]
# [*cluster_url*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::cluster (
  $cluster_name = 'unspecified',
  $cluster_owner = 'unspecified',
  $cluster_latlong = 'unspecified',
  $cluster_url = 'unspecified'
) {
  include 'ganglia::monitor'

  simpcat_fragment { 'gmond+cluster.conf':
    content => template('ganglia/gmond/cluster.erb')
  }
}
