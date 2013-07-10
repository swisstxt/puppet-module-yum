class yum::package::versionlock {

  if $::lsbmajdistrelease == '6' {
    $package_name = 'yum-plugin-versionlock'
  } else {
    $package_name = 'yum-versionlock'
  }

  package {
    $package_name:
      ensure => present;
  }
  
}
