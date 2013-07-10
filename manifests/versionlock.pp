# lock a package to a specific version
define yum::versionlock($ensure, $epoch = '') {
  require yum
  require yum::package::versionlock

  if $ensure == 'absent' {
    $changes = [ "rm ${name}" ]
  } else {
    if $epoch == '' {
      $changes = [ "set ${name}/version ${ensure}" ]
    } else {
      # reverse order of commands fails, why?
      $changes = [ "set ${name}/epoch ${epoch}", "set ${name}/version ${ensure}" ]
    }
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
