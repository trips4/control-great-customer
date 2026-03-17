# @summary Ensure FTP and TNFTP packages are purged
# @description
#   Removes FTP client/server packages to comply with CIS requirements.
class profile::cis::ftp {
  package { ['ftp', 'tnftp']:
    ensure => 'purged',
  }
}
