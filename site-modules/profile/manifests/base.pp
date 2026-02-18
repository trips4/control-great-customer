# The base profile should include component modules that will be on all nodes
class profile::base {
  include profile::sudo_users

  # This was to fix an issue with the openssh-server package on Ubuntu 22.04 Desktop.
  # It was not being installed by the openssh module, and this is a workaround to ensure it is present.
  package { 'openssh-server':
    ensure => 'present',
  }
}
