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
  require yum
  file{"/etc/yum.repos.d/$name.repo":
    stage => 'yum',
    ensure => file,
    replace => false,
    before => Yumrepo[$name],
    require => [
      File['yum_repos_d'],
      Package['yum-priorities'],
    ],
    mode => 0644, owner => root, group => 0;
  }
  yumrepo{$name:
    stage => 'yum',
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
      File['rpm_gpg'],
      Package['yum-priorities']
    ],
  }    
}
