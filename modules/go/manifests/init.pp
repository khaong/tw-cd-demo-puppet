class go {
  file { "/etc/apt/sources.list.d/canonical.list":
    owner => root,
    group => root,
    mode => 0600,
    source => 'puppet:///modules/go/canonical.list';
  }
  
  exec {"apt_update":
    command => "/usr/bin/apt-get update",
    require => File["/etc/apt/sources.list.d/canonical.list"]
  }
  
  exec {"accept_sun_licence":
    command => "/bin/echo \"sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true\" | /usr/bin/debconf-set-selections"
  }
  
  exec {"install_java":
    command => "/usr/bin/apt-get install sun-java6-jre sun-java6-bin",
    require => [Exec["apt_update"], Exec["accept_sun_licence"], File["/etc/apt/sources.list.d/canonical.list"]],
  }
  
  package {
    "unzip":
      ensure => installed,
  }
}