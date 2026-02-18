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
  }
}
