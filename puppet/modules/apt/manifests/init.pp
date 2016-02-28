# == Class: apt
#
# This Puppet class configures Advanced Packaging Tool (APT), Debian's
# package management toolset, to catalog and install packages from
# supplementary sources.
#
class apt {
    exec { 'apt-get update':
        command  => '/usr/bin/apt-get update',
        schedule => hourly,
    }

    exec { 'ins-apt-transport-https':
        command     => '/usr/bin/apt-get update && /usr/bin/apt-get install -y --force-yes apt-transport-https',
        environment => 'DEBIAN_FRONTEND=noninteractive',
        unless      => '/usr/bin/dpkg -l apt-transport-https',
    }

    # file  { '/usr/local/share/wikimedia-pubkey.asc':
    #     source => 'puppet:///modules/apt/wikimedia-pubkey.asc',
    #     before => File['/etc/apt/sources.list.d/wikimedia.list'],
    #     notify => Exec['add_wikimedia_apt_key'],
    # }

    # exec { 'add_wikimedia_apt_key':
    #     command     => '/usr/bin/apt-key add /usr/local/share/wikimedia-pubkey.asc',
    #     before      => File['/etc/apt/sources.list.d/wikimedia.list'],
    #     refreshonly => true,
    # }

    # file { '/etc/apt/sources.list.d/wikimedia.list':
    #     content => template('apt/wikimedia.list.erb'),
    #     before  => Exec['apt-get update'],
    # }

    # file { '/etc/apt/sources.list.d/multiverse.list':
    #     content => template('apt/multiverse.list.erb'),
    #     before  => Exec['apt-get update'],
    # }

    # # prefer Wikimedia APT repository packages in all cases
    # apt::pin { 'wikimedia':
    #     package  => '*',
    #     pin      => 'release o=Wikimedia',
    #     priority => 1001,
    # }

    # if $::shared_apt_cache {
    #     file { '/etc/apt/apt.conf.d/20shared-cache':
    #         content => "Dir::Cache::archives \"${::shared_apt_cache}\";\n",
    #     }

    #     # bug 67976: don't clean up legacy cache locations until apt has been
    #     # reconfigured with new location.
    #     file { ['/vagrant/apt-cache', '/vagrant/composer-cache']:
    #         ensure  => absent,
    #         recurse => true,
    #         purge   => true,
    #         force   => true,
    #         require => File['/etc/apt/apt.conf.d/20shared-cache'],
    #     }
    # }
    
    file { '/etc/apt/apt.conf.d/01no-recommended':
        source => 'puppet:///modules/apt/01no-recommended',
        owner  => 'root',
        group  => 'root',
        mode   => '0444',
    }

    Class['Apt'] -> Package <| |>
}
