class go::server {
  $go_home = "/etc/go"
  File {
    owner => go,
    group => go,
    mode => 0440,
  }
  file {
    "${go_home}/":
      ensure => directory;
    "${go_home}/cruise-config.xml":
      ensure => present,
      source => 'puppet:///modules/go/sample-cruise-config.xml';
  }
}