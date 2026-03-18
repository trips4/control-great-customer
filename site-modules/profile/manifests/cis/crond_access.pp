# @summary Ensure access to /etc/cron.d is configured (CIS 2.4.1.8)
# @description
#   Enforces root ownership and 0700 permissions on /etc/cron.d.
#   Optionally grants read/execute access to specific users via ACLs.
class profile::cis::crond_access (
  Array[String] $allowed_users = ['root', 'ubuntu'],
) {
  package { 'acl':
    ensure => 'present',
  }

  file { '/etc/cron.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  $allowed_users.each |String $u| {
    exec { "cron.d-acl-${u}":
      command => "/usr/bin/setfacl -m u:${u}:rx /etc/cron.d",
      path    => ['/usr/bin', '/bin', '/usr/sbin', '/sbin'],
      require => Package['acl'],
      onlyif  => "/usr/bin/getent passwd ${u}",
      unless  => "/usr/bin/getfacl -p /etc/cron.d | /bin/grep -q '^user:${u}:r-x$'",
    }
  }
}
