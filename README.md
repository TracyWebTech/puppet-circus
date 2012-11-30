# Circus module for Puppet

This module manages [circus](http://circus.io) on Debian distros.

## Requirements

This module require a [apt module](http://forge.puppetlabs.com/puppetlabs/apt) from puppetlabs.
```
puppet module install puppetlabs/apt
```

## Params

### Class circus:

* $endpoint (default: tcp://127.0.0.1:5555)
* $pubsub_endpoint (default: tcp://127.0.0.1:5556)
* $stats_endpoint (default: tcp://127.0.0.1:5557)
* $check_delay (default: 5)
* $stream_backend
* $warmup_delay
* $httpd
* $httpd_host
* $httpd_port
* $debug (default: False)
* $respawn

### Define circus::watcher:

* $ensure (default: present)
* $args
* $shell
* $working_dir
* $uid
* $gid
* $copy_env
* $copy_path
* $war
* $num
* $relimit
* $stderr_stream_class
* $stderr_stream_opts (hash with options)
* $stdout_stream_class
* $stdout_stream_opts (hash with options)
* $send_hup
* $max_retry
* $priority
* $singleton
* $use_sockets
* $max_age
* $max_age_variance
* $extra_conf (hash with options)

### Define circus::plugin
* $ensure (default: present)
* $use
* $variables (hash with plugin variables)

### Define circus::socket
* $ensure (default: present)
* $host
* $port
* $family
* $type

## Examples

Install circus with default values
```puppet
include circus
```

Install circus with web interface
```puppet
class { 'circus':
  check_delay     => 5,
  endpoint        => 'tcp://127.0.0.1:5555',
  pubsub_endpoint => 'tcp://127.0.0.1:5556',
  stats_endpoint  => 'tcp://127.0.0.1:5557',
  httpd           => 'True',
  httpd_host      => '0.0.0.0',
}
```

Add a flapping plugin
```puppet
circus::plugin { 'flapping':
  use       => 'circus.plugins.flapping.Flapping',
  variables => {
    retry_in  => 3,
    max_retry => 2,
  }
}
```

Add a simple watcher
```puppet
circus::watcher { 'dummy':
  cmd          => 'python',
  args         => '-u /home/circus/examples/dummy_fly.py $(circus.wid)',
  warmup_delay => 0,
  numprocesses => 5,
}
```

Add a watcher with socket and stream
```puppet

package { 'chaussette':
  ensure   => installed,
  provider => pip
}

circus::socket { 'webapp':
  host => '0.0.0.0',
  port => '8888',
}

circus::watcher { 'webworker':
  cmd                 => '/usr/local/bin/chaussette',
  args                => '--fd $(circus.sockets.webapp) --pre-hook chaussette.util.setup_bench --post-hook chaussette.util.teardown_bench chaussette.util.bench_app',
  use_sockets         => 'True',
  stdout_stream_class => 'FileStream',
  stdout_stream_opts  => {
    filename => "/tmp/test.log",
    refresh_time => '0.3'
  },
  warmup_delay        => 0,
  numprocesses        => 3,
  require             => Package['chaussette']
}
```
