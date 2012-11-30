class circus::http_packages {

  package { 
    "Mako":
      ensure   => "0.7.0",
      provider => pip;
    "MarkupSafe":
      ensure   => "0.15",
      provider => pip;
    "bottle":
      ensure   => "0.10.9",
      provider => pip;
    "anyjson":
      ensure   => "0.3.1",
      provider => pip;
    "gevent":
      ensure   => "0.13.7",
      provider => pip;
    "gevent-socketio":
      ensure   => present,
      provider => pip;
    "gevent-websocket":
      ensure   => "0.3.6",
      provider => pip;
    "greenlet":
      ensure   => present,
      provider => pip;
    "Beaker":
      ensure   => "1.6.3",
      provider => pip;
    "gevent-zeromq":
      ensure   => present,
      source   => "git+http://github.com/mozilla-services/gevent-zeromq.git",
      provider => pip;

  }

}