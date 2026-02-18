class profile::cis::ubuntu::gdm {
  $directories = [
    '/etc/dconf/db/local.d',
    '/etc/dconf/db/local.d/locks',
  ]
  $directories.each |$dir| {
    file { $dir:
      ensure => directory,
    }
  }
  file { '/etc/dconf/db/local.d/98-screensaver':
    ensure  => 'file',
    content => "[org/gnome/desktop/screensaver]\nlock-enabled=true\nlock-delay=uint32 5\n",
  }
  file { '/etc/dconf/db/local.d/99-session':
    ensure  => 'file',
    content => "[org/gnome/desktop/session]\nidle-delay=uint32 900\n",
  }
  # file { '/etc/dconf/db/local.d/00-login-screen':
  #   ensure  => 'file',
  #   content => "[org/gnome/login-screen]\ndisable-user-list=true",
  # }
  file { '/etc/dconf/db/local.d/locks/99-session':
    ensure  => 'file',
    content => '/org/gnome/desktop/session/idle-delay',
  }
  file { '/etc/dconf/db/local.d/locks/98-screensaver':
    ensure  => 'file',
    content => "/org/gnome/desktop/screensaver/lock-enabled\n/org/gnome/desktop/screensaver/lock-delay",
  }
  # file { '/etc/dconf/db/local.d/locks/00-login-screen':
  #   ensure  => 'file',
  #   content => '/org/gnome/login-screen/disable-user-list',
  # }
  exec { 'dconf update':
    command     => '/usr/bin/dconf update',
    refreshonly => true,
    subscribe   => [
      File['/etc/dconf/db/local.d/98-screensaver'],
      File['/etc/dconf/db/local.d/99-session'],
      File['/etc/dconf/db/local.d/locks/99-session'],
      File['/etc/dconf/db/local.d/locks/98-screensaver'],
    ],
  }

  # $directories = [
  #   '/etc/dconf/db/profile',
  #   '/etc/dconf/db/gdm.d',
  # ]
  # $directories.each |$dir| {
  #   file { $dir:
  #     ensure => directory,
  #   }
  # }
  # file { '/etc/dconf/profile/gdm':
  #   ensure  => file,
  #   content => "user-db:user\nsystem-db:gdm\nfile-db:/usr/share/gdm/greeter-dconf-defaults",
  # }
  # file { '/etc/dconf/db/gdm.d/00-login-screen':
  #   ensure  => file,
  #   content => "[org/gnome/login-screen]\ndisable-user-list=true",
  # }
}
