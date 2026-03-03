class profile::firewalld {
  service { 'firewalld':
    ensure   => 'running',
    enable   => 'true',
    provider => 'systemd',
  }
}
