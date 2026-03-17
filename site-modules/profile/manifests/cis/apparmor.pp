# @summary Manage AppArmor and related utilities
# @description
#   Ensures AppArmor and its utilities are installed and the service is
#   enabled and running.
class profile::cis::apparmor {
  package { ['apparmor', 'apparmor-utils']:
    ensure => 'present',
  }

  service { 'apparmor':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['apparmor'],
  }
}
