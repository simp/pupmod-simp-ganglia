# == Define: ganglia::monitor::collection_group::conf
#
# Configures a collection group section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*name*]
#     The name of the collection group
#
# [*collect_once*]
# [*collect_every*]
# [*collect_time_threshold*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::collection_group::conf (
  $collect_once = '',
  $collect_every = '',
  $collect_time_threshold = ''
) {
  include 'ganglia::monitor::collection_group'

  simpcat_fragment { "gmond_cg+${name}_0_begin.cg":
    content => 'collection_group {
'
  }
  simpcat_fragment { "gmond_cg+${name}_1_conf.cg":
    content => template('ganglia/gmond/collection_group.erb')
  }
  simpcat_fragment { "gmond_cg+${name}_9_end.cg":
    content => '}
'
  }
}
