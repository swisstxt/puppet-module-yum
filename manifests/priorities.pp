class yum::priorities {
  package{'yum-priorities':
    ensure => present,
    name => $::lsbmajdistrelease ? {
      6 => 'yum-plugin-priorities',
      5 => 'yum-priorities',
    },
  }

  # manage this package before any yum repositories
  Package['yum-priorities'] -> Yumrepo <||> 
}
