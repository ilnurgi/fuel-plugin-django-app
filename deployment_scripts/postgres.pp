# ставим постгрес

notice('PLUGIN: django_deploy - install postgress')

$django_app             = hiera_hash('fuel-plugin-django-app')
$database_name          = $django_app['django_db_name']
$database_password      = $django_app['django_db_user_password']
$database_role          = $django_app['django_db_user_name']
$database_role_password = $django_app['django_db_user_password']

class { 'postgresql::server': }

# создадим роль
postgresql::server::role { 
    $database_role:
        password_hash => postgresql_password($database_role, $database_role_password),
}

# создадим базу
postgresql::server::db { 
    $database_name:
        user     => $database_role,
        password => postgresql_password($database_role, $database_role_password),
}
