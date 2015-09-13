php5::generate_ssl_cert { 'app.lh':
    domain => 'app.lh'
}

class { 'apache':
    mpm_module    => prefork,
    user          => 'vagrant',
    group         => 'vagrant',
    default_vhost => false
}

class { '::apache::mod::php':
    path => "${::apache::params::lib_path}/libphp5.so",
}

host { 'app.lh':
    ip => '127.0.0.1'
}

apache::vhost { 'https-app.lh':
    port     => '443',
    docroot  => '/vagrant',
    ssl      => true,
    ssl_cert => '/etc/apache2/ssl/app.lh.crt',
    ssl_key  => '/etc/apache2/ssl/app.lh.key',
}

apache::vhost { 'http-app.lh':
    port     => '80',
    docroot  => '/vagrant',
}