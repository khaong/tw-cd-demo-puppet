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
  
  package {"sun-java6-jdk":
    ensure => installed,
    require => [Exec["apt_update"], File["/etc/apt/sources.list.d/canonical.list"]],
  }
  
  package {
    "unzip":
      ensure => installed,
  }
}