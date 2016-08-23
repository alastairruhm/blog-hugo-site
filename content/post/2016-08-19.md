# celery 中 task 参数 bind=True 的含义

```
@app.task(bind=True)
def dump_context(self, x, y):
    print('Executing task id {0.id}, args: {0.args!r} kwargs: {0.kwargs!r}'.format(
            self.request))
```

> The bind argument means that the function will be a "bound method" so that you can access attributes and methods on the task type instance.

