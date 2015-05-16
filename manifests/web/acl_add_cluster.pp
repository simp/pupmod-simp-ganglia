# == Define: ganglia::web::acl_add_cluster
#
# This adds a cluster definition so that you can update the permissions on a
# public cluster.
#
# For additional information, see
# 'http://sourceforge.net/apps/trac/ganglia/wiki/ganglia-web-2/AuthSystem'
#
# [*name*]
#   The name of the cluster
#
define ganglia::web::acl_add_cluster {

  $l_fname = inline_template('cluster_<%= @name.gsub(/\s+/,"_") %>')

  file { "${ganglia::web::base}/acl/01_${l_fname}.php":
    content =>
      "<?php\n\$acl->add(new Zend_Acl_Resource('$name'), GangliaAcl::ALL_CLUSTERS);\n?>\n"
  }
}
