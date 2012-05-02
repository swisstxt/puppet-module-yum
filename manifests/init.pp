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

class yum {
  package{'yum-priorities':
    ensure => present,
    name => $lsbmajdistrelease ? {
      6 => 'yum-plugin-priorities',
      5 => 'yum-priorities',
    },
  } 
  # ensure there are no other repos
  file{'yum_repos_d':
    path => '/etc/yum.repos.d/',
    source => "puppet://$server/modules/yum/empty",
    ensure => directory,
    recurse => true,
    purge => true,
    ignore => '\.ignore',
    require =>  Package['yum-priorities'],
    mode => 0755, owner => root, group => 0;
  }
  file{'rpm_gpg': 
    path => '/etc/pki/rpm-gpg/',
    source => "puppet://$server/modules/yum/$operatingsystem/rpm-gpg/",
    recurse => true,
    purge => true,
    owner => root, group => 0, mode => '600';
  }
  if $use_munin {
    include yum::munin
  }
  Yumrepo <| |> -> Package <| provider == yum |>
}
