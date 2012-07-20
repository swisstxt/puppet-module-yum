define yum::package::lock($version, $epoch = "") {

  require yum::versionlock

  augeas {
    "${name}_yum_versionlock":
      context => "/etc/yum/pluginconf.d/versionlock.list/$name",
      changes => [ "set version $version", "set epoch $epoch" ];
  }

}
