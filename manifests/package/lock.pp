define yum::package::lock($version, $epoch = "") {

  require yum::versionlock

  augeas {
    "${name}_yum_versionlock":
      context => "/etc/yum/pluginconf.d/versionlock.list/$name",
      # reverse order of commands fails, why?
      changes => [ "set epoch $epoch", "set version $version" ];
  }

}
