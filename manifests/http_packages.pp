class circus::http_packages {

  package { 
    "python-pip":
      ensure => installed;
    "git":
      ensure => installed;
    "Mako":
      ensure   => "0.7.0",
      provider => pip,
      require  => Package["python-pip"];
    "MarkupSafe":
      ensure   => "0.15",
      provider => pip,
      require  => Package["python-pip"];
    "bottle":
      ensure   => "0.10.9",
      provider => pip,
      require  => Package["python-pip"];
    "anyjson":
      ensure   => "0.3.1",
      provider => pip,
      require  => Package["python-pip"];
    "gevent":
      ensure   => "0.13.7",
      provider => pip,
      require  => Package["python-pip"];
    "gevent-socketio":
      ensure   => present,
      provider => pip,
      require  => Package["python-pip"];
    "gevent-websocket":
      ensure   => "0.3.6",
      provider => pip,
      require  => Package["python-pip"];
    "greenlet":
      ensure   => present,
      provider => pip,
      require  => Package["python-pip"];
    "Beaker":
      ensure   => "1.6.3",
      provider => pip,
      require  => Package["python-pip"];
    "gevent-zeromq":
      ensure   => present,
      source   => "git+http://github.com/mozilla-services/gevent-zeromq.git",
      provider => pip,
      require  => [Package["python-pip"], Package["git"]];

  }

}