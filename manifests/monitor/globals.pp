# == Class: ganglia::monitor::globals
#
# Configures the globals section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*globals_daemonize*]
# [*globals_setuid*]
# [*globals_user*]
# [*globals_debug_level*]
# [*globals_max_udp_msg_len*]
# [*globals_mute*]
# [*globals_deaf*]
# [*globals_allow_extra_data*]
# [*globals_host_dmax*]
# [*globals_cleanup_threshold*]
# [*globals_gexec*]
# [*globals_send_metadata_interval*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::globals (
  $globals_daemonize = 'yes',
  $globals_setuid = 'yes',
  $globals_user = 'nobody',
  $globals_debug_level = '0',
  $globals_max_udp_msg_len = '1472',
  $globals_mute = 'no',
  $globals_deaf = 'no',
  $globals_allow_extra_data = 'yes',
  $globals_host_dmax = '0',
  $globals_cleanup_threshold = '300',
  $globals_gexec = 'no',
  $globals_send_metadata_interval = '0'
) {
  include 'ganglia::monitor'

  concat_fragment { 'gmond+globals.conf':
    content => template('ganglia/gmond/globals.erb')
  }
}
