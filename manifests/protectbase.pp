class yum::protectbase {
  package{'yum-protectbase':
    ensure => present,
    name => $lsbmajdistrelease ? {
      6 => 'yum-plugin-protectbase',
      5 => 'yum-protectbase',
    },
  }

  # manage this package before any yum repositories
  Package['yum-protectbase'] -> Yumrepo <||> 
}
