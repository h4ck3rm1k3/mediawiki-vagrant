# == Define: ::role::thumb_on_404::multiwiki
# Configure a multiwiki instance with thumbs on 404.
# See commons.pp
#
# === Parameters
# [*images_path*]
#   URL path to site images. Default "/${title}images".
#
# [*wiki*]
#   Wiki to configure. Default $title.
#
# === Example
# role::thumb_on_404::multiwiki { 'commons' }
#
define role::thumb_on_404::multiwiki(
    $images_path = "/${title}images",
    $wiki        = $title,
) {
    require ::role::mediawiki

    # Enable dynamic thumbnail generation via the thumb.php
    # script for 404 thumb images.
    mediawiki::settings { "${wiki}:thumb.php_on_404":
        values => {
            wgThumbnailScriptPath      => false,
            wgGenerateThumbnailOnParse => false,
            wgUseImageMagick           => true,
        },
    }

    apache::site_conf { "${wiki}:thumb.php on 404":
        site    => $::mediawiki::wiki_name,
        content => template('role/thumb_on_404/apache2.conf.erb'),
    }
}
