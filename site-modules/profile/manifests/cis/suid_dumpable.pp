# @summary Enforce fs.suid_dumpable = 0 (CIS)
# @description
#   Sets fs.suid_dumpable to 0 via /etc/sysctl.d and reloads sysctl when changed.
class profile::cis::suid_dumpable {
  file { '/etc/sysctl.d/60-kernel_sysctl.conf':
    ensure  => file,
    mode    => '0644',
    content => "fs.suid_dumpable = 0\n",
  }

  exec { 'sysctl --system (suid_dumpable)':
    command     => '/sbin/sysctl --system',
    refreshonly => true,
    path        => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    subscribe   => File['/etc/sysctl.d/60-kernel_sysctl.conf'],
  }
}
