# == Class: idea::base
#
# Install IntelliJ IDEA from the official vendor site.
# The required Java runtime environment will not be installed automatically.
#
# === Parameters
#
# [*version*]
#   Specify the version of IntelliJ IDEA which should be installed.
#
# [*url*]
#   Specify the absolute URL of the IntelliJ IDEA tarball. This overrides any
#   version which has been set before.
#
# [*target*]
#   Specify the location of the symlink to the IntelliJ IDEA installation on
#   the local filesystem.
#
# [*timeout*]
#   Download timeout passed to archive module.
#
# === Variables
#
# The variables being used by this module are named exactly like the class
# parameters with the prefix 'idea_', e. g. *idea_version* and *idea_url*.
#
# === Authors
#
# Jochen Schalanda <j.schalanda@smarchive.de>
#
# === Copyright
#
# Copyright 2012, 2013 smarchive GmbH
#
class idea::base (
  $version,
  $url,
  $target,
  $timeout,
) {

  Exec {
    path  => [
      '/usr/local/sbin', '/usr/local/bin',
      '/usr/sbin', '/usr/bin', '/sbin', '/bin',
    ],
    user  => 'root',
    group => 'root',
  }

  archive { "idea-${version}":
    ensure           => present,
    url              => $url,
    checksum         => false,
    src_target       => '/var/tmp',
    target           => '/opt',
    extension        => 'tar.gz',
    timeout          => $timeout,
    strip_components => 1,
  }

  file { $target:
    ensure  => link,
    target  => "/opt/idea-${version}",
    require => Archive["idea-${version}"],
  }
}
