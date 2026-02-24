# @Summary manages installation of CIS Assessor and dependencies
class profile::cis::assessor {
  if $facts['os']['architecture'] == 'aarch64' {
    # This was to resolve issue where assessor was not working on ARM64 architecture.
    # The comply module requires Java to run the scanner, and this ensures it is present on ARM64 systems.
    package { 'open-jdk':
      ensure => installed,
    }
    class { 'comply':
      scanner_source     => 'https://lab1-scm01.triplo.psedemos.com:30303/assessor',
      #assessor_java_path => '<path to wher java is>',
    }
  }
  else {
    class { 'comply':
      scanner_source => 'https://lab1-scm01.triplo.psedemos.com:30303/assessor',
    }
  }
}
