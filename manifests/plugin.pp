define circus::plugin (
  $ensure = present,
  $use,
  $variables = {}
){

  file { "circus-plugin-${name}":
    ensure  => $ensure,
    path    => "${circus::include_dir}/plugin-${name}.ini",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('circus/plugin.ini.erb'),
    notify  => Service['circus'],
  }

}