# @Summary turns on sce_linux for CIS compliance enforcement
#
# @param enforce
#  Whether to enforce compliance or not
class profile::sce (
  Boolean $enforce = false,
) {
  if $enforce {
    if $facts['os']['family'] == 'Ubuntu' {
      include sce_linux
    }
  }
}
