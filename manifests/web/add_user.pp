# == Define: ganglia::web::add_user
#
# Give a user access to the web front-end for ganglia.
#
# == Parameters
#
# [*name*]
#   The user to give access to
#
# [*passwd_hash*]
#   Hashed password for the user. Should be generated using htdigest
#   (for Digest authentication) or htpasswd (for Basic Authentication)
#
# [*realm*]
#   This variable should only be specified if you are using Digest
#   authentication
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define ganglia::web::add_user (
  $passwd_hash,
  $realm = ''
){

  if !defined(Simpcat_build['gweb']) {
    simpcat_build { 'gweb':
      order => ['*.user']
    }
  }

  simpcat_fragment { "gweb+$name.user":
    content => template('ganglia/web/user.erb')
  }
}
