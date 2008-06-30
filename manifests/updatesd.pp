# manifests/updatesd.pp

class yum::updatesd {
    package{'yum-updatesd':
        ensure => present,
    }

    service{'yum-updatesd':
        ensure => running,
        enable => true,
        require => Package['yum-updatesd'],
    }
}

class yum::updatesd::disable inherits yum::updatesd {
    Package['yum-updatesd']{
        ensure => absent,
    }

    Service['yum-updatesd']{
        ensure => stopped,
        enable => false,
        require => undef,
    }
}
