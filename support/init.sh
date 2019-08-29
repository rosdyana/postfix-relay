#!/usr/bin/env bash
/root/site/bin/python manage.py migrate
ps aux | grep -i runserver | grep -v "grep"  | awk '{print $2}' | xargs -I {} kill -9 {}
export GOOGLE_APPLICATION_CREDENTIALS="$(< credentials.json)"
/root/site/bin/python manage.py runserver 0.0.0.0:8000
