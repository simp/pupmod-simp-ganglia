# == Define: ganglia::meta::add_data_source
#
# Add a data source to the gmetad configuration.
#
# See gmetad(1).
#
# == Parameters
#
# [*machines*]
#   An array of machines which service the data source.
#   Entries formatted as: '<address or fqdn>:<port>'
#   If no port is specified, 8649 is assumed
#
# [*data_source_id*]
#   The unique identification string for the data source
#   Will default to $name if no value is provided here
#
# [*polling_interval*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::meta::add_data_source (
  $machines,
  $data_source_id = '',
  $polling_interval = '15'
) {
  include 'ganglia::meta'

  if empty($data_source_id) {
    $ds_id = $name
  }
  else {
    $ds_id = $data_source_id
  }
  concat_fragment { "gmetad+data_source_${name}.conf":
    content => template('ganglia/gmetad/data_source.erb')
  }
}
