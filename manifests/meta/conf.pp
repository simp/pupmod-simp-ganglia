# == Class: ganglia::meta::conf
#
# Create a base gmetad configuration.
# NOTE: ganglia::meta::add_data_source must be called to add a data source
# to the gmetad configuration
#
# See gmetad(1).
#
# For information on the variables for this class, see the default gmetad.conf
# file distributed with ganglia-gmetad
#
# == Parameters
#
# [*debug_level*]
# [*rras*]
# [*scalable*]
# [*gridname*]
# [*authority*]
# [*trusted_hosts*]
# [*all_trusted*]
# [*setuid*]
# [*setuid_username*]
# [*xml_port*]
# [*interactive_port*]
# [*server_threads*]
# [*rrd_rootdir*]
# [*case_sensitive_hostnames*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::meta::conf (
  $debug_level = '0',
  $rras = [
    'RRA:AVERAGE:0.5:1:244',
    'RRA:AVERAGE:0.5:24:244',
    'RRA:AVERAGE:0.5:168:244',
    'RRA:AVERAGE:0.5:672:244',
    'RRA:AVERAGE:0.5:5760:374' ],
  $scalable = 'on',
  $gridname = 'unspecified',
  $authority = "http://$::fqdn/ganglia/",
  $trusted_hosts = ['127.0.0.1'],
  $all_trusted = 'off',
  $setuid = 'on',
  $setuid_username = 'nobody',
  $xml_port = '8651',
  $interactive_port = '8652',
  $server_threads = '4',
  $rrd_rootdir = '/var/lib/ganglia/rrds',
  $case_sensitive_hostnames = '0'
) {
  include 'ganglia::meta'

  concat_fragment { 'gmetad+meta.conf':
    content => template('ganglia/gmetad/conf.erb')
  }
}
