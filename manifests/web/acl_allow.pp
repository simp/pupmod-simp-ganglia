# _Description_
#
# Add permissions to a cluster for a user.
#
# For additional information, see
# 'http://sourceforge.net/apps/trac/ganglia/wiki/ganglia-web-2/AuthSystem'
#
define ganglia::web::acl_allow (
# $username
#     The user to which to assign the role.
    $username,
# $clustername
#     The cluster to which to assign access rights.
    $clustername,
# $permission
#     The Ganglia constant from the web page mentioned above. Valid values are:
#       - VIEW
#       - EDIT
  $permission
) {

  $l_fname = inline_template('<%
if not scope.lookupvar("ganglia::web::valid_permissions").include?(@permission) then
  raise Puppet::ParseError.new("Error: Valid $permission values are #{scope.lookupvar("ganglia::web::valid_permissions").join(",")}")
end
-%>
permission_<%= @username.gsub(/\s+/,"_") %>_<%= @permission %>'
  )

  file { "${ganglia::web::base}/acl/90_${l_fname}.php":
    content => "<?php\n\$acl->allow('$username','$clustername',GangliaAcl::$permission);\n?>\n"
  }
}
