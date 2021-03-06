## MediaWiki-Vagrant

https://www.mediawiki.org/wiki/Mediawiki-vagrant

MediaWiki-Vagrant is a portable MediaWiki development environment. It consists
of a set of configuration scripts that automate the creation of a virtual
machine that runs MediaWiki.

The virtual machine that MediaWiki-Vagrant creates makes it easy to learn
about, modify, and improve MediaWiki's code: useful debugging information is
displayed by default, and various developer tools are set up specifically for
inspecting and interacting with MediaWiki code, including a powerful debugger
and an interactive interpreter. Best of all, because the configuration is
automated and contained in a virtual environment, mistakes are easy to undo.

## Install

You'll need to install recent versions of Vagrant and VirtualBox.

(Note that *experimental* support for Parallels, LXC, VMWare Fusion, and
Microsoft Hyper-V providers exists. See `support/README-lxc.md` or
`support/README-parallels.md` for details on the former two.)

 * VirtualBox: https://www.virtualbox.org/wiki/Downloads
 * Vagrant: https://www.vagrantup.com/downloads-archive.html (the version must be
   1.4.0 or higher). For NFS, use 1.5.4 or higher.

   To check your Vagrant version, run

     vagrant --version

   in a directory without a Vagrantfile (e.g. in your home directory).
 * Hardware virtualization extensions must be enabled in your host computer
   BIOS. The BIOS setting is usually in the "Chipset", "Processor", "CPU", or
   "Security Settings" menu and may be labeled as "VT-x", "Intel
   Virtualization Technology", "Virtualization Extensions", "Vanderpool"
   "AMD-V" or various other names depending on the OEM and system BIOS.
 * (Optional) For better performance on non-Windows hosts, install NFS.  For
   Debian-based systems (including Ubuntu), run:

    sudo apt-get install nfs-kernel-server portmap

Next, you'll need a copy of the mediawiki-vagrant project files.

 * zip: https://git.wikimedia.org/zip/?r=mediawiki/vagrant.git&h=HEAD&format=zip
 * tar.gz: https://git.wikimedia.org/zip/?r=mediawiki/vagrant.git&h=HEAD&format=gz
 * Git: `git clone https://gerrit.wikimedia.org/r/mediawiki/vagrant`

If you've downloaded the zip file or tarball, you will need to extract it to a
directory of your choice. Once you do that, open up a terminal or a
command-prompt, and change your working directory to the location of the
extracted (or git-cloned) files.

If you have cloned the git repository you will also need to clone the
submodules with:

    git submodule update --init --recursive

Run the appropriate setup script for your platform. For Windows, run
`setup.bat`. For Linux and OS X, run `setup.sh`. Some extra Vagrant plugins,
including the bundled mediawiki-vagrant plugin, will be installed.

From there, run `vagrant up` to provision and boot the virtual machine.

You'll now have to wait a bit, as Vagrant needs to retrieve the base image from
Canonical, retrieve some additional packages, and install and configure each of
them in turn.

If it all worked, you should be able to browse to http://127.0.0.1:8080/ and
see the main page of your MediaWiki instance.


## Use

To access a command shell on your virtual environment, run `vagrant ssh` from
the root mediawiki-vagrant directory or any of its subdirectories.

From there, run `hhvmsh` to interactively evaluate PHP code in a MediaWiki
context, or `mysql` to get an authenticated SQL shell on your wiki's database.

The admin account on MediaWiki is `admin` / `vagrant`.


## Update

When the vagrant Virtual Machine is running, it will periodically run Puppet
(an open source configuration management tool) to update its configuration,
which keeps various software packages up to date. To avoid clobbering any
changes you may have made to MediaWiki's source code, Puppet will not update
MediaWiki.

To pick up other changes to the install, on the host computer in the directory
with the vagrant files run `git pull --rebase` and then `vagrant reload`.
The latter will restart the VM.


## Extend

You can add roles to MediaWiki-Vagrant! A 'role' represents a set of software
configurations required for giving this machine some special function.
Mediawiki-Vagrant has several commands to manage enabled roles.
See `vagrant roles -h` for help on usage.

If you'd like to use the Mediawiki-Vagrant codebase to describe a development
environment that you could then share with other developers, you should do so
by adding a role file to puppet/modules/role/manifests/ and submitting it as a
patch to the Mediawiki-Vagrant project.


## Settings

For information about settings, see settings.d/README.

## Testing

You will need bundler < 1.8 (`gem install bundler -v '<1.8'`). Then:

    bundler install
    rake

Will run all the linter, test and doc generation commands.

## Troubleshoot

Stuck? Here's where to get help.

 * https://www.mediawiki.org/wiki/Mediawiki-Vagrant#Troubleshooting
 * irc://chat.freenode.net/#mediawiki

Please report any bugs on Wikimedia's Phabricator:
 * https://phabricator.wikimedia.org/maniphest/task/create/?projects=MediaWiki-Vagrant

Patches and contributions are welcome!
See <https://www.mediawiki.org/wiki/How_to_become_a_MediaWiki_hacker> for details.
