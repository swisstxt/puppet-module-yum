define yum::package::lock($version, $epoch = "") {

  require yum::versionlock

  $change_version = "set $name/version $version"
  $change_epoch = "set $ame/epoch $epoch"
  if $epoch == '' {
    $changes = [ $change_version ]
  } else {
    # reverse order of commands fails, why?
    $changes = [ $change_epoch, $change_version ]
  }

  augeas {
    "${name}_yum_versionlock":
      context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      incl      => '/etc/yum/pluginconf.d/versionlock.list',
      lens      => 'YumVersionlock.lns',
      load_path => '/var/lib/puppet/lib/augeas/lenses',
      changes   => $changes;
  }

}
