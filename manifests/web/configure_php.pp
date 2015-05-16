# == Class: ganglia::web::configure_php
#
# PHP Configuration for the web front-end for ganglia.
#
# For additional information, see '/var/www/html/ganglia/conf.php'
#
# == Parameters
#
#  [*config_location*]
#  [*auth_system*]
#  [*template_name*]
#  [*gmetad_root*]
#  [*rrds*]
#  [*dwoo_compiled_dir*]
#  [*views_dir*]
#  [*conf_dir*]
#  [*rrdtool*]
#  [*rrdtool_slope_mode*]
#  [*rrdcached_socket*]
#  [*graphdir*]
#  [*graphreport_stats*]
#  [*ganglia_ip*]
#  [*ganglia_port*]
#  [*max_graphs*]
#  [*hostcols*]
#  [*metriccols*]
#  [*show_meta_snapshot*]
#  [*default_refresh*]
#  [*cpu_user_color*]
#  [*cpu_nice_color*]
#  [*cpu_system_color*]
#  [*cpu_wio_color*]
#  [*cpu_idle_color*]
#  [*mem_used_color*]
#  [*mem_shared_color*]
#  [*mem_cached_color*]
#  [*mem_buffered_color*]
#  [*mem_free_color*]
#  [*mem_swapped_color*]
#  [*load_one_color*]
#  [*proc_run_color*]
#  [*cpu_num_color*]
#  [*num_nodes_color*]
#  [*jobstart_color*]
#  [*load_colors_100*]
#  [*load_colors_75_100*]
#  [*load_colors_50_75*]
#  [*load_colors_25_50*]
#  [*load_colors_0_25*]
#  [*load_colors_down*]
#  [*load_scale*]
#  [*default_metric_color*]
#  [*default_metric*]
#  [*strip_domainname*]
#  [*zoom_support*]
#  [*default_time_range*]
#  [*graph_engine*]
#  [*graphite_url_base*]
#  [*graphite_rrd_dir*]
#  [*cachedata*]
#  [*cachefile*]
#  [*cachetime*]
#  [*graph_size_small_height*]
#  [*graph_size_small_width*]
#  [*graph_size_small_fudge_0*]
#  [*graph_size_small_fudge_1*]
#  [*graph_size_small_fudge_2*]
#  [*graph_size_medium_height*]
#  [*graph_size_medium_width*]
#  [*graph_size_medium_fudge_0*]
#  [*graph_size_medium_fudge_1*]
#  [*graph_size_medium_fudge_2*]
#  [*graph_size_large_height*]
#  [*graph_size_large_width*]
#  [*graph_size_large_fudge_0*]
#  [*graph_size_large_fudge_1*]
#  [*graph_size_large_fudge_2*]
#  [*graph_size_xlarge_height*]
#  [*graph_size_xlarge_width*]
#  [*graph_size_xlarge_fudge_0*]
#  [*graph_size_xlarge_fudge_1*]
#  [*graph_size_xlarge_fudge_2*]
#  [*graph_size_mobile_height*]
#  [*graph_size_mobile_width*]
#  [*graph_size_mobile_fudge_0*]
#  [*graph_size_mobile_fudge_1*]
#  [*graph_size_mobile_fudge_2*]
#  [*raph_size_default_height*]
#  [*graph_size_default_width*]
#  [*graph_size_default_fudge_0*]
#  [*graph_size_default_fudge_1*]
#  [*graph_size_default_fudge_2*]
#  [*default_graph_size*]
#  [*case_sensitive_hostnames*]
#  [*metric_groups_initially_collapsed*]
#  [*overlay_events*]
#  [*overlay_events_exclude_ranges*]
#  [*overlay_events_line_type*]
#  [*overlay_events_provider*]
#  [*overlay_events_file*]
#  [*overlay_events_tick_alpha*]
#  [*overlay_events_shade_alpha*]
#  [*graph_colors*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::web::configure_php (
  $config_location = "${ganglia::web::base}/conf.php",
  $auth_system = 'enabled',
  $template_name = 'default',
  $gmetad_root = '/var/lib/ganglia',
  $rrds = '/var/lib/ganglia/rrds',
  $dwoo_compiled_dir = '/var/lib/ganglia/dwoo',
  $views_dir = '/var/lib/ganglia/conf',
  $conf_dir = '/var/lib/ganglia/conf',
  $rrdtool = '/usr/bin/rrdtool',
  $rrdtool_slope_mode = false,
  $rrdcached_socket = '',
  $graphdir = './graph.d',
  $graphreport_stats = true,
  $ganglia_ip = '127.0.0.1',
  $ganglia_port = '8652',
  $max_graphs = '0',
  $hostcols = '4',
  $metriccols = '2',
  $show_meta_snapshot = 'yes',
  $default_refresh = '300',
  $cpu_user_color = '3333bb',
  $cpu_nice_color = 'ffea00',
  $cpu_system_color = 'dd0000',
  $cpu_wio_color = 'ff8a60',
  $cpu_idle_color = 'e2e2f2',
  $mem_used_color = '5555cc',
  $mem_shared_color = '0000aa',
  $mem_cached_color = '33cc33',
  $mem_buffered_color = '99ff33',
  $mem_free_color = '00ff00',
  $mem_swapped_color = '9900CC',
  $load_one_color = 'CCCCCC',
  $proc_run_color = '0000FF',
  $cpu_num_color = 'FF0000',
  $num_nodes_color = '00FF00',
  $jobstart_color = 'ff3300',
  $load_colors_100 = 'ff634f',
  $load_colors_75_100 = 'ffa15e',
  $load_colors_50_75 = 'ffde5e',
  $load_colors_25_50 = 'caff98',
  $load_colors_0_25 = 'e2ecff',
  $load_colors_down = '515151',
  $load_scale = '1.0',
  $default_metric_color = '555555',
  $default_metric = 'load_one',
  $strip_domainname = false,
  $zoom_support = true,
  $default_time_range = 'hour',
  $graph_engine = 'rrdtool',
  $graphite_url_base = 'http://127.0.0.1/render',
  $graphite_rrd_dir = '/opt/graphite/storage/rrd',
  $cachedata = '1',
  $cachefile = '/var/lib/ganglia/conf/ganglia_metrics.cache',
  $cachetime = '1200',
  $graph_size_small_height = '65',
  $graph_size_small_width = '200',
  $graph_size_small_fudge_0 = '0',
  $graph_size_small_fudge_1 = '0',
  $graph_size_small_fudge_2 = '0',
  $graph_size_medium_height = '95',
  $graph_size_medium_width = '300',
  $graph_size_medium_fudge_0 = '0',
  $graph_size_medium_fudge_1 = '14',
  $graph_size_medium_fudge_2 = '28',
  $graph_size_large_height = '150',
  $graph_size_large_width = '480',
  $graph_size_large_fudge_0 = '0',
  $graph_size_large_fudge_1 = '0',
  $graph_size_large_fudge_2 = '0',
  $graph_size_xlarge_height = '300',
  $graph_size_xlarge_width = '650',
  $graph_size_xlarge_fudge_0 = '0',
  $graph_size_xlarge_fudge_1 = '0',
  $graph_size_xlarge_fudge_2 = '0',
  $graph_size_mobile_height = '95',
  $graph_size_mobile_width = '220',
  $graph_size_mobile_fudge_0 = '0',
  $graph_size_mobile_fudge_1 = '0',
  $graph_size_mobile_fudge_2 = '0',
  $graph_size_default_height = '100',
  $graph_size_default_width = '400',
  $graph_size_default_fudge_0 = '0',
  $graph_size_default_fudge_1 = '0',
  $graph_size_default_fudge_2 = '0',
  $default_graph_size = 'default',
  $case_sensitive_hostnames = true,
  $metric_groups_initially_collapsed = false,
  $overlay_events = false,
  $overlay_events_exclude_ranges = 'array("month", "year")',
  $overlay_events_line_type = 'dashed',
  $overlay_events_provider = 'json',
  $overlay_events_file = '/var/lib/ganglia/conf/events.json',
  $overlay_events_tick_alpha = '30',
  $overlay_events_shade_alpha = '50',
  $graph_colors = 'array("0000A3", "FF3300", "FFCC33", "00CC66", "B88A00", "33FFCC", "809900", "FF3366", "FF33CC", "CC33FF", "CCFF33", "FFFF66", "33CCFF")'
) {

  file { $config_location:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('ganglia/web/conf.erb'),
    require => File["${ganglia::web::base}/acl"]
  }

  file { $views_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'apache',
    mode   => '0775'
  }

  file { "${ganglia::web::base}/acl":
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => true,
    require => Package['gweb']
  }

  file { "${ganglia::web::base}/acl/README":
    content => "# All files in this directory are managed by Puppet.\n"
  }

  validate_absolute_path($rrds)
  validate_absolute_path($dwoo_compiled_dir)
  validate_absolute_path($cachefile)
  validate_absolute_path($overlay_events_file)
  validate_absolute_path($views_dir)
  validate_absolute_path($conf_dir)
  validate_absolute_path($config_location)
  validate_absolute_path($gmetad_root)
  validate_absolute_path($rrdtool)
  validate_bool($rrdtool_slope_mode)
  validate_bool($graphreport_stats)
  validate_integer($ganglia_port)
  validate_integer($max_graphs)
  validate_integer($hostcols)
  validate_integer($metriccols)
  validate_integer($default_refresh)
  validate_bool($strip_domainname)
  validate_bool($zoom_support)
  validate_integer($cachedata)
  validate_integer($cachetime)
  validate_integer($graph_size_small_height)
  validate_integer($graph_size_small_width)
  validate_integer($graph_size_small_fudge_0)
  validate_integer($graph_size_small_fudge_1)
  validate_integer($graph_size_small_fudge_2)
  validate_integer($graph_size_medium_height)
  validate_integer($graph_size_medium_width)
  validate_integer($graph_size_medium_fudge_0)
  validate_integer($graph_size_medium_fudge_1)
  validate_integer($graph_size_medium_fudge_2)
  validate_integer($graph_size_large_height)
  validate_integer($graph_size_large_width)
  validate_integer($graph_size_large_fudge_0)
  validate_integer($graph_size_large_fudge_1)
  validate_integer($graph_size_large_fudge_2)
  validate_integer($graph_size_xlarge_height)
  validate_integer($graph_size_xlarge_width)
  validate_integer($graph_size_xlarge_fudge_0)
  validate_integer($graph_size_xlarge_fudge_1)
  validate_integer($graph_size_xlarge_fudge_2)
  validate_integer($graph_size_mobile_height)
  validate_integer($graph_size_mobile_width)
  validate_integer($graph_size_mobile_fudge_0)
  validate_integer($graph_size_mobile_fudge_1)
  validate_integer($graph_size_mobile_fudge_2)
  validate_integer($graph_size_default_height)
  validate_integer($graph_size_default_width)
  validate_integer($graph_size_default_fudge_0)
  validate_integer($graph_size_default_fudge_1)
  validate_integer($graph_size_default_fudge_2)
  validate_bool($case_sensitive_hostnames)
  validate_bool($metric_groups_initially_collapsed)
  validate_bool($overlay_events)
  validate_integer($overlay_events_tick_alpha)
  validate_integer($overlay_events_shade_alpha)
}
