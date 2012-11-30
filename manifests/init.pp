class circus (
  $endpoint        = undef,
  $pubsub_endpoint = undef,
  $stats_endpoint  = undef,
  $check_delay     = undef,
  $stream_backend  = undef,
  $warmup_delay    = undef,
  $httpd           = undef,
  $httpd_host      = undef,
  $httpd_port      = undef,
  $debug           = undef,
  $respawn         = undef
) {

  $include_dir = '/etc/circus/conf.d'
  $circus_debug = $debug

  include apt

  apt::source { 'circus':
    location    => 'http://ppa.launchpad.net/roman-imankulov/circus/ubuntu',
    key         => '6EF1FC75',
    include_src => true,
  }

  package { 'circus':
    ensure  => present,
    require => Apt::Source['circus'],
  }

  service { 'circus':
    ensure  => running,
    enable  => true,
    require => Package['circus'],
  }

  file { 'circus.ini':
    ensure => present,
    path   => '/etc/circus/circusd.ini',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    content => template('circus/circus.ini.erb'),
    require => Package['circus'],
    notify => Service['circus'],
  }

  file { 'circus include dir':
    ensure => present,
    path   => $include_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  if $httpd {
    include circus::http_packages
  }

}