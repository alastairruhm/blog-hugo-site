+++
title = "supervisor 在 python 项目部署中的应用"
date = "2016-04-20"
tags = ["python", "supervisor"]
+++



## Q&A

1. supervisor app 配置中的 command 只能配置一行，比如stackoverflow这个问题 
  
  * [python - supervisor - how to run multiple commands - Stack Overflow](http://stackoverflow.com/questions/28994647/supervisor-how-to-run-multiple-commands)
  
  那么使用 virtualenv 之后，部署 flask 项目实际需要 `source venv/bin/activate;python manager.py runserver` 两条指令。这样配置 supervisor 无法启动应用。
  
  解决办法有两种思路：
  
  * 在 virtualenv 隔离环境下安装使用 gunicorn ，配置 supervisor program 时，直接使用 virtualenv 环境下的 gunicorn 命令
  
    ```
    [program:app]
    command=/root/project/venv/bin/gunicorn ....
    ```

  * 在项目中添加 `runinenv.sh` 脚本，内容如下

    ```
    VENV=$1
    if [ -z $VENV ]; then
    echo "usage:runinenv [virtualenv_path] CMDS"
    exit 1
    fi
    source ${VENV}/bin/activate
    shift 1
    echo "Executing $@ in ${VENV}"
    exec "$@"
    deactivate
    ```




