# coding: utf-8

import django 
import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "blog.settings")
django.setup()

from django.contrib.auth.models import User

username = '<%= @database_role %>'
password = '<%= @database_password %>'
if not User.objects.filter(username=username).exists():
    u = User(username=username)
    u.set_password(password)
    u.is_superuser = True
    u.is_staff = True
    u.save()