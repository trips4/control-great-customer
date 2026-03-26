# The base profile should include component modules that will be on all nodes
class profile::base {
  case $facts['kernel'] {
    'Linux': {
      include profile::sudo_users
      # This was to fix an issue with the openssh-server package on Ubuntu 22.04 Desktop.
      # It was not being installed by the openssh module, and this is a workaround to ensure it is present.
      package { 'openssh-server':
        ensure => 'present',
      }
      include profile::cis::assessor
      #include profile::firewalld
    }
    'windows': {
      include profile::cis::assessor

      dsc_userrightsassignment { 'deny_rdp_guests_contractors':
        dsc_policy   => 'deny_log_on_through_remote_desktop_services',
        dsc_identity => ['BUILTIN\Guests'],
        dsc_ensure   => 'Present',
      }
      dsc_userrightsassignment { 'change_the_time_zone':
        dsc_policy   => 'change_the_time_zone',
        dsc_identity => ['BUILTIN\Guests'],
        dsc_ensure   => 'Present',
      }
    }
    default: {
      fail("Unsupported kernel ${facts['kernel']}")
    }
  }
}
