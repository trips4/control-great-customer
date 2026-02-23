# @Summary turns on sce_linux for CIS compliance enforcement
#
# @param enforce
#  Whether to enforce compliance or not
class profile::sce (
  Boolean $enforce = false,
) {
  if $enforce {
    if $facts['os']['family'] == 'Ubuntu' or $facts['os']['family'] == 'RedHat' {
      include sce_linux
      notify { "SCE Linux profile included because OS Family is ${facts['os']['family']}": }
    }
  }
  notify { "SCE Linux profile included because OS Family is ${facts['os']['family']}": }
}
