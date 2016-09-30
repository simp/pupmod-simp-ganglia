# == Class: ganglia::monitor::mods
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::monitor::mods {
  $fragdir = simpcat_fragmentdir('gmond')
  simpcat_build { 'gmond_mods':
    order        => ['begin', '*.module', 'end'],
    target       => "$fragdir/modules.conf",
    parent_build => 'gmond'
  }
  simpcat_fragment { 'gmond_mods+begin':
    content => 'modules {
'
  }
  simpcat_fragment { 'gmond_mods+end':
    content => '}
'
  }
}
