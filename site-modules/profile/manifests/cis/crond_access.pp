# @summary Ensure access to /etc/cron.d is configured (CIS 2.4.1.8)
# @description
#   Enforces root ownership and 0700 permissions on /etc/cron.d.
class profile::cis::crond_access {
  file { '/etc/cron.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }
}
