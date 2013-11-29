class mariadb::repository {

  if $::rfc1918_gateway == 'true' {
    exec { 'mariadb-apt-key':
     path        => '/usr/bin:/bin:/usr/sbin:/sbin',
     command     => "apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db",
     unless      => 'apt-key list | grep 0xcbcb082a1bb943db >/dev/null 2>&1',
#     command     => "apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1BB943DB",
#     unless      => 'apt-key list | grep 1BB943DB >/dev/null 2>&1',
    }

  } else {
    apt::key { 'mariadb':
      key         => '0xcbcb082a1bb943db',
#      key        => '1BB943DB',
      key_server => 'keyserver.ubuntu.com',
    }
  }

#Apt::Source['mariadb'] -> Package['python-software-properties']

  apt::source { 'mariadb':
#    location    => 'http://mirror.1000mbps.com/mariadb/repo/10.0/ubuntu precise',
    location    => 'http://mirror.1000mbps.com/mariadb/repo/10.0/ubuntu',
    repos       => 'precise main',
    key         => '0xcbcb082a1bb943db',
#    key        => '1BB943DB',
    key_server => 'keyserver.ubuntu.com',
    required_packages = 'python-software-properties',
  }

}
