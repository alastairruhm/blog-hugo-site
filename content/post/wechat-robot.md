# 微信接入图灵机器人

## 图灵机器人

首先创建 [图灵机器人](http://www.tuling123.com/) 创建一个机器人，获取 `APIkey`

## Python网页微信API

直接使用 [liuwons/wxBot: Python网页微信API](https://github.com/liuwons/wxBot)

```
git clone https://github.com/liuwons/wxBot
cd wxBot
virtualenv .venv
source .venv/bin/activate
```

创建一个名为 `conf.ini` 的配置文件，填入之前的 `APIKey`

```
[main]
key=1d2678900f734aa0a23734ace8aec5b1
```

执行 

```
python bot.py
```
    
## 参考

* [用wxBot和图灵机器人API实现微信群聊机器人 CSDN.NET](http://blog.csdn.net/tobacco5648/article/details/50802922)
* [挖掘微信Web版通信的全过程 // 老谭笔记](http://www.tanhao.me/talk/1466.html/)
* [liuwons/wxBot: Python网页微信API](https://github.com/liuwons/wxBot)
    



