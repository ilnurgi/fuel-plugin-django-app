# папка на ноде, куда копируется deployments_scripts с мастер ноды
$plugin_source_dir = '/etc/fuel/plugins/fuel-plugin-django-app-1.0/'

$blog_path   = "/var/www/blog/"
$blog_python = "${blog_path}env/bin/python"
$blog_pip    = "${blog_path}env/bin/pip"

# вытаскиваем из хиеры наши параметры
$django_app             = hiera_hash('fuel-plugin-django-app')
$database_engine        = $django_app['django_db_engine']
$database_name          = $django_app['django_db_name']
$database_password      = $django_app['django_db_user_password']
$database_role          = $django_app['django_db_user_name']
$database_role_password = $django_app['django_db_user_password']
$database_host          = $django_app['django_db_host']
$database_port          = $django_app['django_db_port']

# копируем django приложение
file {
    "${blog_path}":
        ensure  => 'directory',
        recurse => true,
        source  => "${plugin_source_dir}blog/"
}

# ставим зависимости
exec {
    "${blog_pip} install -r ${blog_path}requirements":
}

# создаем конфиг для приложения, с параметрами которые настроил пользователь
file {
    "${blog_path}settings.yaml":
        ensure  => present,
        content => template("${plugin_source_dir}blog/settings.yaml.rb")
}

# генерируем питон файл, который создаст суперпользователя
file {
    "${blog_path}create_superuser.py":
        ensure  => present,
        content => template("${blog_path}create_superuser.py.rb")
}

exec {
    ["${blog_python} manage.py migrate --noinput",
     "${blog_python} manage.py collectstatic --noinput",
     "${blog_python} create_superuser.py"]:
        cwd => "${blog_path}"
}