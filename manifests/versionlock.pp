class yum::versionlock {

  package {
    'yum-versionlock':
      ensure => present;
  }
  
}
