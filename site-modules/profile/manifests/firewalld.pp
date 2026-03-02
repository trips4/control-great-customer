class profile::firewalld {
  service { 'firewalld':
    ensure   => 'stopped',
    enable   => 'true',
    provider => 'systemd',
  }
}
