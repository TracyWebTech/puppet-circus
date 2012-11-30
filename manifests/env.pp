define circus::env(
  $ensure = present,
  $watchers = $title,
  $variables
) {

  file { "env-${name}":
    ensure  => $ensure,
    path    => "${circus::include_dir}/env-${name}.ini",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('circus/env.ini.erb'),
  }

}
