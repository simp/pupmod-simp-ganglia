# == Define: ganglia::web::acl_add_private_cluster
#
# Add a private cluster to the Ganglia PHP interface
#
# For additional information, see
# 'http://sourceforge.net/apps/trac/ganglia/wiki/ganglia-web-2/AuthSystem'
#
# == Parameters
#
# [*name*]
#   The name of the private cluster.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::web::acl_add_private_cluster {

  $l_fname = inline_template('private_cluster_<%= @name.gsub(/\s+/,"_") %>')

  file { "${ganglia::web::base}/acl/01_${l_fname}.php":
    content => "<?php\n\$acl->addPrivateCluster('$name');\n?>\n"
  }
}
