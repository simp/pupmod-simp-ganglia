# == Class: ganglia::monitor::collection_group
#
# Configure a collection group in gmond.conf.
#
# See gmond(1) and gmond.conf(5) for additional details.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::collection_group {
  $fragdir = simpcat_fragmentdir('gmond')
  simpcat_build { 'gmond_cg':
    order        => [ '*.cg' ],
    target       => "$fragdir/collection_group.conf",
    parent_build => 'gmond'
  }
}
