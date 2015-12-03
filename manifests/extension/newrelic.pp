# == Class: php::extension::newrelic
#
# Install and configure the newrelic PHP extension
#
# === Parameters
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
#
# [*inifile*]
#   The path to the extension ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::newrelic
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2015 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::newrelic(
  $ensure   = $php::extension::newrelic::params::ensure,
  $package  = $php::extension::newrelic::params::package,
  $provider = $php::extension::newrelic::params::provider,
  $inifile  = $php::extension::newrelic::params::inifile,
  $settings = $php::extension::newrelic::params::settings
) inherits php::extension::newrelic::params {

  php::extension { 'newrelic':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  # Skip using augeas, it's broken for empty values apparently
  # and we don't need it
  # see https://github.com/jippi/puppet-php/issues/107
  # This is totally hacky and depends on nrsysmond
  # But works for our usage for now
  php::config { 'php-extension-newrelic':
    file   => $inifile,
    section => 'newrelic',
    setting => 'newrelic.license',
    value => $::nrsysmond::license_key,
  }

}
