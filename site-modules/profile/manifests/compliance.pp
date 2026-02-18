# @Summary manages installation of CIS Assessor and dependencies
class profile::cis_assessor {
  
  
  
  
  if $facts['os']['architecture'] == 'aarch64' {
    # This was to resolve issue where assessor was not working on ARM64 architecture.
    # The comply module requires Java to run the scanner, and this ensures it is present on ARM64 systems.
    package { 'open-jdk':
      ensure => installed,
    }
    class { 'comply':
      scanner_source     => '<my source',
      assessor_java_path => '<path to wher java is',
    }
  }
  else {
    class { 'comply':
      scanner_source => '<my source',
    }
  }
}
