class go::server {
  include go
  
  $go_home = "/etc/go"
  $go_server_file = "/home/ubuntu/go-server-2.2.0-13083.deb"
  
  File {
    owner => go,
    group => go,
    mode => 0660,
  }
  
  exec { "download_cruise_server":
    unless => "/bin/ls $go_server_file",
    command => "/usr/bin/wget http://download01.thoughtworks.com/go/2.2/ga/go-server-2.2.0-13083.deb -O $go_server_file"
  }
  
  exec { "install_go_server":
    command => "/usr/bin/dpkg -i $go_server_file",
    require => [Exec["download_cruise_server"], Exec["install_java"]]
  }
    
  file {
    "${go_home}/":
      ensure => directory;
    "${go_home}/cruise-config.xml":
      ensure => present,
      source => 'puppet:///modules/go/sample-cruise-config.xml',
      require => Exec['install_go_server'],
  }
}