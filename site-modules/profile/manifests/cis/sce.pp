# @Summary turns on sce_linux for CIS compliance enforcement
#
# @param enforce
#  Whether to enforce compliance or not
class profile::cis::sce (
  Boolean $enforce = false,
) {
  if $enforce {
    if $facts['os']['name'] in ['Ubuntu', 'AlmaLinux'] {
      include sce_linux
      notify { "SCE Linux is enabled for CIS compliance on ${facts['os']['name']}" :
      }
    }
    elsif $facts['os']['family'] == 'windows' {
      include sce_windows
      notify { "SCE Windows is enabled for CIS compliance on ${facts['os']['name']}" :
      }
    }
    else {
      notify { "SCE compliance enforcement is not supported on ${facts['os']['name']}" :
      }
    }
  }
  notify { "SCE compliance enforcement is set to ${enforce} for ${facts['os']['name']}" :
  }
}
