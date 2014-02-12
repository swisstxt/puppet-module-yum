#
# yum module
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Copyright 2010, Atizo AG
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class yum(
  $purge_unmanaged_repos = true,
) {
  include yum::priorities
  include yum::protectbase

  # ensure there are no other repos
  file{'yum_repos_d':
    path => '/etc/yum.repos.d/',
    source => 'puppet:///modules/yum/empty',
    ensure => directory,
    recurse => true,
    purge => $purge_unmanaged_repos ? {
      false   => false,
      default => true,
    },
    ignore => '\.ignore',
    require => Package['yum-priorities'],
    mode => 0644, owner => root, group => 0;
  }
  file{'rpm_gpg': 
    path => '/etc/pki/rpm-gpg/',
    source => "puppet:///modules/yum/${::operatingsystem}/rpm-gpg/",
    recurse => true,
    purge => $purge_unmanaged_repos ? {
      false   => false,
      default => true,
    },
    owner => root, group => 0, mode => '0644';
  }
  file {'/etc/yum.conf':
    ensure => 'present';
  }
  if $::use_munin {
    include yum::munin
  }

  # ensure that all yum repos are managed before any non-yum packages
  Package <| (title != yum-priorities and title != yum-protectbase and title != yum-cron and title != yum-updatesd) |> <- 
  Yumrepo <||> <-
  File['rpm_gpg']
}
