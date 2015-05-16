# == Class: ganglia::monitor::mods
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::mods {
  $fragdir = fragmentdir('gmond')
  concat_build { 'gmond_mods':
    order        => ['begin', '*.module', 'end'],
    target       => "$fragdir/modules.conf",
    parent_build => 'gmond'
  }
  concat_fragment { 'gmond_mods+begin':
    content => 'modules {
'
  }
  concat_fragment { 'gmond_mods+end':
    content => '}
'
  }
}
