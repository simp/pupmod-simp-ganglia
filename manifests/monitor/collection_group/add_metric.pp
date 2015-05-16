# == Define: ganglia::monitor::collection_group::add_metric
#
# Adds a metric to a collection group section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*name*]
#   The name of the metric
#
# [*collection_group_name*]
#   must match the $name value passed to collection_group::conf
#
# [*metric_title*]
# [*metric_value_threshold*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::collection_group::add_metric (
  $collection_group_name,
  $metric_title = '',
  $metric_value_threshold = ''
) {
  include 'ganglia::monitor::collection_group'

  concat_fragment { "gmond_cg+${collection_group_name}_5_${name}_metric.cg":
    content => template('ganglia/gmond/collection_metric.erb'),
  }
}
