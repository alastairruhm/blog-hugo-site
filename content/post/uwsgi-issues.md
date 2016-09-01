# uwsgi 问题

(venv) [root@cloudmanager-test cloudmanager]# python manage.py runserver
CommandError: You must set settings.ALLOWED_HOSTS if DEBUG is False.

参考：
http://stackoverflow.com/questions/24857158/commanderror-you-must-set-settings-allowed-hosts-if-debug-is-false



配置： ALLOWED_HOSTS = ['*']

