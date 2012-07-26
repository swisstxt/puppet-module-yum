define yum::package::lock($version, $epoch = "") {

  require yum::versionlock

  $change_version = "set version $version"
  $change_epoch = "set epoch $epoch"
  if $epoch == '' {
    $changes = [ $change_version ]
  } else {
    # reverse order of commands fails, why?
    $changes = [ $change_epoch, $change_version ]
  }

  augeas {
    "${name}_yum_versionlock":
      context => "/etc/yum/pluginconf.d/versionlock.list/$name",
      changes => $changes;
  }

}
