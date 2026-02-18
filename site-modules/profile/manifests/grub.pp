class profile::grub {

  # This was to allow disable the requirment for a password to boot node.
  file { '/etc/grub.d/09_unrestricted':
    ensure  => file,
    mode    => '0755',
    content => 'CLASS="--class gnu-linux --class gnu --class os --unrestricted"',
  }
}
