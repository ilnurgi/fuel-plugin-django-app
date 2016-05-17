$www_dir     = "/var/www/"
$blog_dir    = "${www_dir}blog/"
$blog_logs   = "${blog_dir}logs/"
$blog_python = "${www_dir}env/bin/python"

file {
    [$www_dir, $blog_dir, $blog_logs]:
        ensure => 'directory',
}

package {
    ['python-pip', 'python-dev', 'libpq-dev']:
        ensure => 'present',
}

exec {
    'install virtualenv':
        command => 'pip install virtualenv',
        path    => '/usr/bin/',
        require => Package['python-pip'],
}

exec {
    'create environment':
        command => 'virtualenv --no-site-packages env',
        path    => '/usr/local/bin/',
        cwd     => $blog_dir,
        require => [
            Package['python-pip'],
            File[$blog_dir]
        ],
}