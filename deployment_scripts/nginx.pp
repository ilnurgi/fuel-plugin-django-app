$plugin_source_dir = '/etc/fuel/plugins/fuel-plugin-django-app-1.0/'
package {
    'nginx':
        ensure => 'present',
}

service {
    'nginx':
        ensure => 'running',
        enable => 'true'
}

file {
    '/etc/nginx/sites-available/blog':
        content => file("${plugin_source_dir}etc/nginx/sites-available/blog"),
}

file {
    '/etc/nginx/sites-enabled/default':
        ensure => absent,
}

file {
    '/etc/nginx/sites-enabled/blog':
        ensure => 'link',
        target => '/etc/nginx/sites-available/blog',
        notify => Service['nginx']
}