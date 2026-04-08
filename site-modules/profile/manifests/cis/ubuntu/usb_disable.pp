# @summary Disable the usb-storage kernel module (CIS 1.1.1.9)
# @description
#   Ensures usb-storage is disabled via modprobe configuration and unloads
#   the module if it is currently loaded.
class profile::cis::ubuntu::usb_disable {
  file { '/etc/modprobe.d/60-usb-storage.conf':
    ensure  => file,
    content => "install usb-storage /bin/false\nblacklist usb-storage\n",
    mode    => '0644',
  }

  exec { 'unload-usb-storage':
    command     => '/sbin/modprobe -r usb-storage || /sbin/rmmod usb-storage',
    path        => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    refreshonly => true,
    subscribe   => File['/etc/modprobe.d/60-usb-storage.conf'],
    onlyif      => '/sbin/lsmod | /bin/grep -q ^usb_storage',
  }
}
