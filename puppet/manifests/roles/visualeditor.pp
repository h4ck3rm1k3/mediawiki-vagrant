# == Class: role::visualeditor
# Provisions the VisualEditor extension, backed by a local Parsoid
# instance.
class role::visualeditor {
    include role::mediawiki
    include role::parsoid

    mediawiki::extension { 'VisualEditor':
        settings => template('ve-config.php.erb'),
    }
}