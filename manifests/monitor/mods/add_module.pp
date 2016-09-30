# == Define: ganglia::monitor::mods::add_module
#
# Adds a module to the modules section of the gmond.conf file.
#
# See gmond(1) or gmond.conf(5) for additional information.
#
# == Parameters
#
# [*name*]
#     The value used for 'name' in the module definition
#
# [*mod_language*]
# [*mod_enabled*]
# [*mod_path*]
# [*mod_params*]
# [*mod_param*]
#   An array with each element in the form "<param name>=<module value>"
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::monitor::mods::add_module (
  $mod_language = '',
  $mod_enabled = '',
  $mod_path = '',
  $mod_params = '',
  $mod_param = ''
) {
  include 'ganglia::monitor::mods'

  simpcat_fragment { "gmond_mods+${name}.module":
    content => template('ganglia/gmond/module.erb')
  }
}
