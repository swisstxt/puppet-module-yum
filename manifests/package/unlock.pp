define yum::package::unlock {

  Class['yum::package::unlock'] -> Class['yum::versionlock']

  augeas {
    "${name}_yum_versionlock":
      context => "/etc/yum/pluginconf.d/versionlock.list",
      changes => [ "rm $name" ];
  }

}
