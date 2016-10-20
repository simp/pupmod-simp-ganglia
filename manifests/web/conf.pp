# == Class: ganglia::web::conf
#
# Configures the web front-end for ganglia.
#
# == Parameters
#
# [*ganglia_dir*]
#   The directory containing the ganglia web files
#
# [*ganglia_port*]
#   The port over which to accept connections for the ganglia front-end
#
# [*ganglia_listen*]
#   Whether or not to add a listen statement to the ganglia http config.
#
# [*ganglia_secret*]
#   The 'secret' value used by Ganglia to protect user sessions
#
# [*client_nets*]
#   Clients that will be able to access the web server
#
# [*auth_type*]
#   Apache authorization type. Should be Digest, Basic, or None
#
# [*auth_name*]
#   Apache AuthName
#
# [*auth_digest_domain*]
#   Apache AuthDigestDomain
#
# [*auth_user_file*]
#   File to store users and passwords in
#
# [*ganglia_server_name*]
#   Hostname (alias in DNS) to point at $::fqdn/ganglia/
#
# [*ldap_auth*]
#   Whether or not to authenticate against LDAP
#
# [*ldap_group*]
#   An LDAP groupOfNames that the user must be in to access the system. This
#   does *not* translate to permissions inside of Ganglia.
#
# [*ldap_servers*]
#   A space delimited list of LDAP servers to attempt to connect to. This is
#   *not* a URI string.  The default is to properly parse and use the
#   hiera('ldap::uri') setting.
#
# [*ldap_search*]
#   The space under which to search for entries.
#
# [*ldap_binddn*]
#   The Bind DN to use when binding to the LDAP server.
#
# [*ldap_bindpw*]
#   The Bind password to use when binding to the LDAP server.
#
# [*ssl_protocols*]
#   See the Apache SSLProtocol documentation.
#
# [*ssl_cipher_suite*]
#   See the Apache SSLCipherSuite documentation.
#
# [*ssl_certificate_file*]
#   See the Apache SSLCertificateFile documentation.
#   If you change this from the default, you will need to ensure that you
#   manage the file and that apache restarts when the file is updated.
#
# [*ssl_certificate_key_file*]
#   See the Apache SSLCertificateKeyFile documentation.
#   If you change this from the default, you will need to ensure that you
#   manage the file and that apache restarts when the file is updated.
#
# [*ssl_ca_certificate_path*]
#   See the Apache SSLCACertificatePath documentation.
#   If you change this from the default, you will need to ensure that you
#   manage the file and that apache restarts when the file is updated.
#
# [*ssl_verify_client*]
#   See the Apache SSLVerifyClient documentation.
#
# [*ssl_verify_depth*]
#   See the Apache SSLVerifyDepth documentation.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class ganglia::web::conf (
    $ganglia_dir = '/var/www/html/ganglia/',
    $ganglia_port = '4430',
    $ganglia_listen = true,
    $ganglia_secret = passgen("ganglia_${::fqdn}"),
    $client_nets = hiera('client_nets'),
    $auth_type = 'Digest',
    $auth_name = 'ganglia',
    $auth_digest_domain = '/var/www/html/ganglia/',
    $auth_user_file = '/usr/local/apache/ganglia-passwords',
    $ganglia_server_name = '',
    $ldap_auth = true,
    $ldap_group = '',
    $ldap_servers = inline_template('<%= scope.call_function("hiera",["ldap::uri"]).map{|x| x = x.gsub(/ldaps?:\/\//,"") } %>'),
    $ldap_search = inline_template('ou=People,<%= scope.call_function("hiera",["ldap::base_dn"]) %>'),
    $ldap_binddn = hiera('ldap::bind_dn'),
    $ldap_bindpw = hiera('ldap::bind_pw'),
    $ssl_protocols = ['TLSv1','TLSv1.1','TLSv1.2'],
    $ssl_cipher_suite = hiera('openssl::cipher_suite',['HIGH']),
    $ssl_certificate_file = "/etc/pki/public/${::fqdn}.pub",
    $ssl_certificate_key_file = "/etc/pki/private/${::fqdn}.pem",
    $ssl_ca_certificate_path = '/etc/pki/cacerts',
    $ssl_verify_client = 'optional',
    $ssl_verify_depth = '10'
) {
  include 'ganglia::web'

  simp_apache::add_site { 'ganglia':
    content => template('ganglia/web/apache.erb')
  }

  if !defined(Simpcat_build['gweb']) {
    simpcat_build { 'gweb':
      order => ['*.user']
    }
  }

  $outfile = simpcat_output('gweb')
  file { $auth_user_file:
    owner   => 'root',
    group   => 'apache',
    mode    => '0640',
    source  => "file://${outfile}",
    require => Simpcat_build['gweb']
  }

  iptables::add_tcp_stateful_listen { 'allow_ganglia':
    order       => '11',
    client_nets => $client_nets,
    dports      => $ganglia_port
  }

  validate_absolute_path($ganglia_dir)
  validate_integer($ganglia_port)
  validate_bool($ganglia_listen)
  validate_net_list($client_nets)
  validate_absolute_path($auth_digest_domain)
  validate_absolute_path($auth_user_file)
  validate_bool($ldap_auth)
  validate_array($ssl_protocols)
  validate_array($ssl_cipher_suite)
  validate_absolute_path($ssl_certificate_file)
  validate_absolute_path($ssl_certificate_key_file)
  validate_absolute_path($ssl_ca_certificate_path)
  validate_array_member($ssl_verify_client, ['none','optional','require','optional_no_ca'])
  validate_integer($ssl_verify_depth)
}
