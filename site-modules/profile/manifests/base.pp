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
      dsc_userrightsassignment { 'Deny log on through Remote Desktop Services to Guests and Local Accounts':
        ensure     => 'present',
        user_right => 'SeDenyRemoteInteractiveLogonRight',
        users      => ['Builtin\Guests', 'NT AUTHORITY\Local account'],
        groups     => [],
        provider   => 'powershell',
      }
    }
    default: {
      fail("Unsupported kernel ${facts['kernel']}")
    }
  }
}
