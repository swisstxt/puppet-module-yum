define yum::repo(
  $descr = 'absent',
  $baseurl = 'absent', 
  $mirrorlist = 'absent',
  $enabled = 0,
  $gpgcheck = 0,
  $gpgkey = 'absent', 
  $failovermethod = 'absent',
  $priority = 99,
  $exclude = 'absent',
  $includepkgs = 'absent'
) {
  file{"/etc/yum.repos.d/$name.repo":
    ensure => file,
    replace => false,
    before => Yumrepo[$name],
    require => [
      Class['yum'],
      File['yum_repos_d'],
      Package['yum-priorities'],
    ],
    mode => 0644, owner => root, group => 0;
  }
  yumrepo{$name:
    descr => $descr,
    baseurl => $baseurl, 
    mirrorlist => $mirrorlist,
    enabled => $enabled,
    gpgcheck => $gpgcheck,
    gpgkey => $gpgkey, 
    failovermethod => $failovermethod,
    priority => $priority,
    exclude => $exclude,
    includepkgs => $includepkgs,
    require => [
      Class['yum'],
      File['rpm_gpg'],
      Package['yum-priorities']
    ],
  }    
}
