class profile::cis::ubuntu::gnome (
  String $banner_message = 'My Special Banner Message',
) {
  $gdm_profile = 'gdm'

  # Create profile directory
  file { '/etc/dconf/profile':
    ensure => directory,
  }

  # Create GDM profile
  file { "/etc/dconf/profile/${gdm_profile}":
    ensure  => file,
    content => "user-db:user\nsystem-db:${gdm_profile}\nfile-db:/usr/share/${gdm_profile}/greeter-dconf-defaults\n",
    require => File['/etc/dconf/profile'],
  }

  # Create dconf database directory
  file { "/etc/dconf/db/${gdm_profile}.d":
    ensure => directory,
  }

  # Create banner message configuration
  file { "/etc/dconf/db/${gdm_profile}.d/01-banner-message":
    ensure  => file,
    content => "[org/gnome/login-screen]\nbanner-message-enable=true\nbanner-message-text='${banner_message}'\n",
    require => File["/etc/dconf/db/${gdm_profile}.d"],
  }

  # Create login-screen configuration to disable user list
  file { "/etc/dconf/db/${gdm_profile}.d/00-login-screen":
    ensure  => file,
    content => "[org/gnome/login-screen]\ndisable-user-list=true\n",
    require => File["/etc/dconf/db/${gdm_profile}.d"],
  }

  # Update dconf database
  exec { 'dconf update gnome':
    command     => '/usr/bin/dconf update',
    refreshonly => true,
    subscribe   => [
      File["/etc/dconf/profile/${gdm_profile}"],
      File["/etc/dconf/db/${gdm_profile}.d/01-banner-message"],
      File["/etc/dconf/db/${gdm_profile}.d/00-login-screen"],
    ],
  }
}
