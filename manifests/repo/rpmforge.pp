class yum::repo::rpmforge(
  $priority = 15,
  $includepkgs = undef
) {
  Class['yum::repo::rpmforge'] <- Class['yum']

  yum::repo{'rpmforge':
    descr => "RPMForge RHEL$releasever packages - dag",
    baseurl => 'http://mirror1.hs-esslingen.de/repoforge/redhat/el$releasever/en/$basearch/rpmforge',
    mirrorlist => 'http://mirror1.hs-esslingen.de/repoforge/redhat/el$releasever/en/mirrors-rpmforge',
    enabled => 1,
    priority => $priority,
    includepkgs => $includepkgs,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
  }
  yum::repo{'rpmforge-extras':
    descr => "RPMForge RHEL$releasever packages - extras",
    baseurl => 'http://mirror1.hs-esslingen.de/repoforge/redhat/el$releasever/en/$basearch/extras',
    mirrorlist => 'http://mirror1.hs-esslingen.de/repoforge/redhat/el$releasever/en/mirrors-rpmforge-extras',
    enabled => 1,
    priority => $priority,
    includepkgs => $includepkgs,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
  }
}
