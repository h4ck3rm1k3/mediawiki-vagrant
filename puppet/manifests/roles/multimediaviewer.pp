# == Class: role::multimediaviewer
# This role provisions the MultimediaViewer extension,
# which shows images and their metadata in a lightbox
# when the user clicks on the thumbnails.
class role::multimediaviewer {
    include role::mediawiki
    include role::multimedia
    include ::apache::mods::headers

    mediawiki::extension { 'MultimediaViewer':
    }

    apache::conf { 'Content-Disposition: attachment on ?download':
        site    => $mediawiki::wiki_name,
        content => template('content_disposition_attachment.conf.erb'),
    }
}