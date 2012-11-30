define circus::watcher(
  $ensure = present,
  $cmd,
  $args = undef,
  $shell = undef,
  $working_dir = undef,
  $uid = undef,
  $gid = undef,
  $copy_env = undef,
  $copy_path = undef,
  $warmup_delay,
  $numprocesses,
  $relimit = undef,
  $stderr_stream_class = undef,
  $stderr_stream_opts = {},
  $stdout_stream_class = undef,
  $stdout_stream_opts = {},
  $send_hup = undef,
  $max_retry = undef,
  $priority = undef,
  $singleton = undef,
  $use_sockets = undef,
  $max_age = undef,
  $max_age_variance = undef,
  $hooks = {},
  $extra_conf = {}
) {

  file { "circus-watcher-${name}":
    ensure  => $ensure,
    path    => "${circus::include_dir}/watcher-${name}.ini",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('circus/watcher.ini.erb'),
    notify  => Service['circus'],
  }

  if $ensure == present {
    service { "circus-watcher-${name}":
      ensure     => running,
      path       =>  ['/usr/bin'],
      start      => "circusctl start ${name}",
      restart    => "circusctl restart ${name}",
      stop       => "circusctl stop ${name}",
      status     => "circusctl status ${name} | grep active",
      hasrestart => false, 
      hasstatus  => false,
      provider   => base,
      subscribe  => File["circus-watcher-${name}"],
    }
  }

}