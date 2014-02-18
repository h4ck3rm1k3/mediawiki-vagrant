# == Class: role::wikidiff2
# Installs wikidiff2 package that speeds up diff generation in MediaWiki
# and configures MW to use it

class role::wikidiff2 {
    include packages::wikidiff2

    mediawiki::settings { 'wikidiff2':
        ensure       => present,
        values       => [
            '$wgExternalDiffEngine = "wikidiff2";',
        ],
        require      => Package["php-wikidiff2"],
    }
}
