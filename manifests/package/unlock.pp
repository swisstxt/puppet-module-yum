define yum::package::unlock {

  require yum::versionlock

  augeas {
    "${name}_yum_versionlock":
      context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      incl      => '/etc/yum/pluginconf.d/versionlock.list',
      lens      => 'YumVersionlock.lns',
      load_path => '/var/lib/puppet/lib/augeas/lenses',
      changes   => [ "rm $name" ];
  }

}
