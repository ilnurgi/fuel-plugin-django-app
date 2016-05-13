notice('PLUGIN: fuel-plugin-django-app-deploy.pp')

file { 
    '/tmp/fuel-plugin-django-app.txt':
        ensure => absent,
        content => "fuel-plugin-django-app",
}