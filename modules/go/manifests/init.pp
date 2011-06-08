class go {
  file { "/etc/apt/sources.list.d/canonical.list":
    owner => root,
    group => root,
    mode => 0600,
    source => 'puppet:///modules/go/canonical.list';
  }
}