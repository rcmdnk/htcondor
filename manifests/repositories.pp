# Class: htcondor::repositories
#
# Provides yum repositories for HTCondor installation
class htcondor::repositories {
  $dev_repos       = $htcondor::dev_repositories
  $prev_repos      = $htcondor::prev_repositories
  $stable_version  = $htcondor::stable_version
  $gpgcheck        = $htcondor::gpgcheck
  $gpgkey          = $htcondor::gpgkey
  $condor_priority = $htcondor::condor_priority
  $major_release   = regsubst($::operatingsystemrelease, '^(\d+)\.\d+$', '\1')

  case $::osfamily {
    'RedHat'  : {
      if $dev_repos {
        $repo    = "htcondor-development"
        $descr   = "HTCondor Development RPM Repository for Redhat Enterprise Linux ${major_release}"
        $baseurl = "http://research.cs.wisc.edu/htcondor/yum/development"
      } elsif $prev_repos {
        $repo    = "htcondor-stable"
        $descr   = "HTCondor Stable RPM Repository for Redhat Enterprise Linux  ${major_release}"
        $baseurl = "http://research.cs.wisc.edu/htcondor/yum/stable"
      } else {
        $repo    = "htcondor-stable"
        $descr   = "HTCondor Stable RPM Repository for Redhat Enterprise Linux ${major_release}"
        $baseurl = "http://research.cs.wisc.edu/htcondor/yum/stable/${stable_version}"
      }
      yumrepo { $repo:
        descr    => $descr,
        baseurl  => "${baseurl}/rhel${major_release}",
        enabled  => 1,
        gpgcheck => bool2num($gpgcheck),
        gpgkey   => $gpgkey,
        priority => $condor_priority,
        exclude  => 'condor.i386, condor.i686',
        before   => [Package['condor']],
      }
    }
    'Debian'  : {
      # http://research.cs.wisc.edu/htcondor/debian/
      notify { 'Debian based systems currently not supported': }
    }
    'Windows' : {
      # http://research.cs.wisc.edu/htcondor/manual/latest/3_2Installation.html#SECTION00425000000000000000
      notify { 'Windows based systems currently not supported': }
    }
    default   : {
      $osfamily = $::osfamily

      notify { "OS family '${osfamily}' not recognised": }
    }
  }

}
