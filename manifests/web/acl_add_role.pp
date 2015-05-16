# == Class: ganglia::web::acl_add_role
#
# Add a user to the Ganglia PHP interface
#
# For additional information, see
# 'http://sourceforge.net/apps/trac/ganglia/wiki/ganglia-web-2/AuthSystem'
#
# == Parameters
#
# [*username*]
#   The user to which to assign the role.
#
# [*acl*]
#   The Ganglia constant from the web page mentioned above. Valid values are:
#     - GUEST
#     - ADMIN
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::web::acl_add_role (
  $username,
  $acl
) {

  $l_fname = inline_template('<%
if not scope.lookupvar("ganglia::web::valid_acls").include?(@acl) then
  raise Puppet::ParseError.new("Error: Valid $acl values are #{scope.lookupvar("ganglia::web::valid_acl").join(",")}")
end
-%>
role_<%= @username.gsub(/\s+/,"_") %>_<%= @acl %>'
  )

  file { "${ganglia::web::base}/acl/00_${l_fname}.php":
    content => "<?php\n\$acl->addRole('$username',GangliaAcl::$acl);\n?>\n"
  }
}
