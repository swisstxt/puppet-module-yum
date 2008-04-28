# modules/yum/manifests/init.pp - manage yum
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# Adapted by Puzzle ITC - haerry+puppet(at)puzzle.ch
# 

#modules_dir { "yum": }


class yum {
    # autoupdate
    package { yum-cron:
        ensure => present
    }

    service { yum-cron:
        enable => true,
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package[yum-cron],
    }

    case $operatingsystem {
        centos: {
            case $lsbdistrelease {
                5: { include yum::centos::five }
                default: { 
                    info("no class for this version yet defined, try to configure it with the version for 5")
                    include yum::centos::five
                }
            }
        }
        default: { fail("no managed repo yet for this distro") }
    }
    
}

class yum::centos::five {
    file{[ "/etc/yum.repos.d/base.repo",
           "/etc/yum.repos.d/addons.repo",
           "/etc/yum.repos.d/extras.repo",
           "/etc/yum.repos.d/centosplus.repo",
           "/etc/yum.repos.d/contrib.repo",
           "/etc/yum.repos.d/dlutter-rhel5.repo",
           "/etc/yum.repos.d/dlutter-source.repo",
           "/etc/yum.repos.d/rpmforge-rhel5.repo",
           "/etc/yum.repos.d/centos5-atrpms.repo",
           "/etc/yum.repos.d/centos5-plus.repo",
           "/etc/yum.repos.d/epel.repo",
           "/etc/yum.repos.d/epel-debuginfo.repo",
           "/etc/yum.repos.d/epel-source.repo",
           "/etc/yum.repos.d/epel-testing.repo",
           "/etc/yum.repos.d/epel-testing-debuginfo.repo",
           "/etc/yum.repos.d/epel-testing-source.repo",
           "/etc/yum.repos.d/kbs-CentOS-Extras.repo",
           "/etc/yum.repos.d/kbs-CentOS-Extras-testing.repo",
           "/etc/yum.repos.d/kbs-CentOS-Misc.repo",
           "/etc/yum.repos.d/kbs-CentOS-Testing.repo" ]:
        ensure => file,
        replace => false,
        require => File[yum_repos_d],
        mode => 0644, owner => root, group => 0;
     }
    yumrepo {base:
        descr => 'CentOS-$releasever - Base',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {updates:
        descr => 'CentOS-$releasever - Updates',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yumrepo {addons:
        descr => 'CentOS-$releasever - Addons',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=addons',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yumrepo {extras:
        descr => 'CentOS-$releasever - Extras',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yumrepo {centosplus:
        descr => 'CentOS-$releasever - Centosplus',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }
    yumrepo {contrib:
        descr => 'CentOS-$releasever - Contrib',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 10,
    }


    yumrepo { dlutter-rhel5:
        descr => 'Unsupported RHEL5 packages (lutter)',
        baseurl => 'http://people.redhat.com/dlutter/yum/rhel/5/$basearch',
        enabled => 1,
        gpgcheck => 0,
        priority => 15,
    }

    yumrepo { dlutter-source:
        descr => 'Sources for additional test packages (lutter)',
        baseurl => 'http://people.redhat.com/dlutter/yum/SRPMS/',
        enabled => 1,
        gpgcheck => 0,
        priority => 15,
    }

    yumrepo { rpmforge-rhel5:
        descr => 'RPMForge RHEL5 packages',
        baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
	    priority => 30,
	}
	yumrepo {centos5-atrpms:
	    descr => 'CentOS $releasever - $basearch - ATrpms',
        baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable',
	    enabled => 1,
		gpgcheck => 0,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
	    priority => 30,
    }
	yumrepo { centos5-plus:
	    descr => 'CentOS-$releasever - Plus',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever',
		priority => 15,
	}
    yumrepo { epel:
	    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
	    priority => 16,
    }
	yumrepo { epel-debuginfo:
	    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 16,
    }
    yumrepo { epel-source:
	    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
	    enabled => 1,
    	gpgcheck => 1,
	    failovermethod => priority,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    	priority => 16,
    }
	yumrepo { epel-testing:
	    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
        baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
    }
    yumrepo { epel-testing-debuginfo:
	    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
        baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch/debug',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
    }
	yumrepo { epel-testing-source:
	    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
        baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/SRPMS',
    	enabled => 1,
		gpgcheck => 1,
		failovermethod => priority,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 17,
    }
	yumrepo { kbs-CentOS-Extras:
	    descr => 'CentOS.Karan.Org-EL$releasever - Stable',
        baseurl => 'http://centos.karan.org/el$releasever/extras/stable/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 20,
    }
	yumrepo { kbs-CentOS-Extras-Testing:
	    descr => 'CentOS.Karan.Org-EL$releasever - Testing',
        baseurl => 'http://centos.karan.org/el$releasever/extras/testing/$basearch/RPMS/',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
		priority => 20,
	}
    yumrepo { kbs-CentOS-Misc:
	    descr => 'CentOS.Karan.Org-EL$releasever - Stable',
        baseurl => 'http://centos.karan.org/el$releasever/misc/stable/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 20,
    }
    yumrepo { kbs-CentOS-Misc-Testing:
	    descr => 'CentOS.Karan.Org-EL$releasever - Testing',
        baseurl => 'http://centos.karan.org/el$releasever/misc/testing/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 20,
	}
}

class yum::prerequisites {
    package{yum-priorities:
        ensure => present,
    } 

	#gpg key
    file{yum_repos_d:
        path => '/etc/yum.repos.d/',
        source => "puppet://$server/yum/empty",
        ensure => directory,
        recurse => true,
        purge => true,
        mode => 0755, owner => root, group => 0;
    }
    #gpg key
	file {rpm_gpg: 
	    path => '/etc/pki/rpm-gpg/',
        source => [ "puppet://$server/yum/${operatingsystem}.${lsbdistrelease}/rpm-gpg/",
                    "puppet://$server/yum/CentOS.5/rpm-gpg/" ],
	    recurse => true,
        purge => true,
		owner => root,
    	group => 0,
	    mode => '600',
    }
}

define yum::managed_yumrepo (
    $descr = 'absent',
    $baseurl = 'absent', 
    $mirrorlist = 'absent',
    $enabled = 0,
    $gpgcheck = 0,
    $gpgkey = 'absent', 
    $failovermethod = 'absent',
    $priority = 99){

    # ensure that everything is setup
    include yum::prerequisites
    
    file{"/etc/yum.repos.d/${name}.repo":
        ensure => file,
        replace => false,
        before => Yumrepo[$name],
        require => File[yum_repos_d],
        mode => 0644, owner => root, group => 0;
    }

    yumrepo{$name:
        descr => $descr,
        baseurl => $baseurl, 
        enabled => $enabled,
        gpgcheck => $gpgcheck,
        gpgkey => $gpgkey, 
        failovermethod => $failovermethod,
        priority => $priority,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }    
}

