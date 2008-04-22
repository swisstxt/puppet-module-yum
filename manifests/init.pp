# modules/yum/manifests/init.pp - manage yum
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# Adapted by Puzzle ITC - haerry+puppet(at)puzzle.ch
# 

#modules_dir { "yum": }
class yum {

    # package stuff to prio
    package { [ yum-priorities, yum-cron ]:
        ensure => present
    }

    service { yum-cron: 
        enable => true,
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package[yum-cron],
    }

    # set the mirror
    $rpm_mirror_real = $rpm_mirror ? {
        '' => "yum.ww2.ch", 
        default => $rpm_mirror, 
    }

    # disable default repos
    yumrepo { [ "base", "updates", "addons", "extras" ]:
        priority => 1,
        enabled => 0,
        require => Package[yum-priorities],
    }
    yumrepo { [ "centosplus", "contrib" ] :
        priority => 2,
        enabled => 0,
        require => Package[yum-priorities],
    }


    # puzzle repos
    yumrepo { puzzle_base:
        descr => "CentOS-$releasever - Base",
        baseurl => "http://${rpm_mirror_real}/centos/$releasever/$basearch/RPMS.os",
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
        priority => 1,
    }
    yumrepo { puzzle_updates:
        descr => "CentOS-$releasever - Updates",
        baseurl => "http://${rpm_mirror_real}/centos/$releasever/$basearch/RPMS.updates",
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
        priority => 1,
    }
    yumrepo { puzzle_extras:
        descr => "CentOS-$releasever - Extras",
        baseurl => "http://${rpm_mirror_real}/centos/$releasever/$basearch/RPMS.extras",
        enabled => 1,
        gpgcheck => 0,
        priority => 1,
    }
    yumrepo { puzzle_fasttrack:
        descr => "CentOS-$releasever - Fasttrack",
        baseurl => "http://${rpm_mirror_real}/centos/$releasever/$basearch/RPMS.fasttrack",
        enabled => 1,
        gpgcheck => 0,
        priority => 1,
    }
    yumrepo { puzzle_misc:
        descr => "CentOS-$releasever - ww2k",
        baseurl => "http://${rpm_mirror_real}/centos/$releasever/$basearch/RPMS.misc",
        enabled => 1,
        gpgcheck => 0,
        priority => 1,
    }
    yumrepo { puzzle_ww2k:
        descr => "CentOS-$releasever - ww2k",
        baseurl => "http://${rpm_mirror_real}/centos/$releasever/$basearch/RPMS.ww2k",
        enabled => 1,
        gpgcheck => 0,
        priority => 2,
    }


    # dlutter repos for puppet
    yumrepo { dlutter-rhel5:
        descr => "Unsupported RHEL5 packages (lutter)",
        baseurl => 'http://people.redhat.com/dlutter/yum/rhel/5/$basearch',
        enabled => 1,
        gpgcheck => 0,
        priority => 4,
    }
    yumrepo { dlutter-source:
        descr => 'Sources for additional test packages (lutter)',
        baseurl => 'http://people.redhat.com/dlutter/yum/SRPMS/',
        enabled => 1,
        gpgcheck => 0,
        priority => 4,
    }

    # extra sources
	yumrepo {centos5-atrpms:
	    descr => "CentOS $releasever - $basearch - ATrpms",
        baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
	    priority => 20,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
    yumrepo { centos5-plus:
        descr => "CentOS-$releasever - Plus",
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever',
		priority => 5,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
	}
    yumrepo { epel:
	    descr => "Extra Packages for Enterprise Linux $releasever - $basearch",
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
	    priority => 6,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
    yumrepo { epel-debuginfo:
	    descr => "Extra Packages for Enterprise Linux $releasever - $basearch - Debug",
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 6,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
	yumrepo { epel-source:
	    descr => "Extra Packages for Enterprise Linux $releasever - $basearch - Source",
        mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
	    enabled => 1,
    	gpgcheck => 1,
	    failovermethod => priority,
		gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    	priority => 6,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
    yumrepo { epel-testing:
	    descr => "Extra Packages for Enterprise Linux $releasever - Testing - $basearch",
        baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 7,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
	yumrepo { epel-testing-debuginfo:
	    descr => "Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug",
        baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch/debug',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 7,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
	yumrepo { epel-testing-source:
	    descr => "Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source",
        baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/SRPMS',
    	enabled => 1,
		gpgcheck => 1,
		failovermethod => priority,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
		priority => 7,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
    yumrepo { kbs-CentOS-Extras:
	    descr => "CentOS.Karan.Org-EL$releasever - Stable",
        baseurl => 'http://centos.karan.org/el$releasever/extras/stable/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 10,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
    }
    yumrepo { kbs-CentOS-Extras-Testing:
	    descr => "CentOS.Karan.Org-EL$releasever - Testing",
        baseurl => 'http://centos.karan.org/el$releasever/extras/testing/$basearch/RPMS/',
	    enabled => 1,
    	gpgcheck => 1,
	    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
		priority => 10,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
	}
    yumrepo { kbs-CentOS-Misc:
	    descr => "CentOS.Karan.Org-EL$releasever - Stable",
        baseurl => 'http://centos.karan.org/el$releasever/misc/stable/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 10,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
	}
    yumrepo { kbs-CentOS-Misc-Testing:
	    descr => "CentOS.Karan.Org-EL$releasever - Testing",
        baseurl => 'http://centos.karan.org/el$releasever/misc/testing/$basearch/RPMS/',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
	    priority => 10,
        require => [ File[rpm_gpg],
            Package[yum-priorities]
        ],
	}
    yumrepo { rpmforge-rhel5:
      	descr => "RPMForge RHEL5 packages",
        baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
	    enabled => 1,
		gpgcheck => 1,
    	gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
	    priority => 20,
		require => [ File[rpm_gpg], 
		    Package[yum-priorities]
		],
	}

	#gpg key
	file {rpm_gpg: 
	    path => "/etc/pki/rpm-gpg/",
    	source => "puppet://$server/yum/rpm-gpg/",
	    recurse => true,
		owner => root,
    	group => 0,
	    mode => '600',
    }
}
