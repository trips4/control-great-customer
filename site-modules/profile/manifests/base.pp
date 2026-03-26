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
        dsc_policy      => 'SeDenyRemoteInteractiveLogonRight',
        dsc_identity    => [
          'BUILTIN\Guests',
          'DOMAIN\Contractors',
        ],
        dsc_ensure      => 'Present',
        validation_mode => 'resource',
      }
      notify { 'Deny RDP logins for Guests and Contractors':
      }
    }
    default: {
      fail("Unsupported kernel ${facts['kernel']}")
    }
  }
}
