define circus::socket(
  $ensure = present,
  $host = undef,
  $port = undef,
  $family = undef,
  $type = undef,
  $path = undef
) {

  file { "circus-socket-${name}":
    ensure  => $ensure,
    path    => "${circus::include_dir}/socket-${name}.ini",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('circus/socket.ini.erb'),
  }

}
