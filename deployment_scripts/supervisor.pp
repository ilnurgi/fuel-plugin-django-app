$plugin_source_dir = '/etc/fuel/plugins/fuel-plugin-django-app-1.0/'
package {
    'supervisor':
        ensure => 'present',
}

service {
    'supervisor':
        ensure => 'running',
        enable => 'true'
}

file {
    '/etc/supervisor/conf.d/blog.conf':
        content => file("${plugin_source_dir}etc/supervisor/conf.d/blog.conf"),
        notify  => Service['supervisor']
}