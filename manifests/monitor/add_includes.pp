# == Class: ganglia::monitor::add_includes
#
# Add include statements to the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*includes*]
#   list of files to include in array format
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::add_includes (
  $includes = '/etc/ganglia/conf.d/*.conf'
) {
  include 'ganglia::monitor'

  simpcat_fragment { 'gmond+includes.conf':
    content => template('ganglia/gmond/includes.erb')
  }
}
