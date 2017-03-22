+++
title = "sequelize 笔记"
date = "2017-03-22"
tags = ["sequelize", "nodejs", "node"]
+++

## misc

### 排序问题

```js
order: [
	['created_at', 'desc nulls last'] // nulls last 语法使该字段为 null 值时排在后面
]
```

### batch operation hooks

如果使用 `model.destory` 方法删除记录，对每个删除的记录都触发 `afterDestroy hooks`，则必须加入 `individualHooks: true`  参数，例：

```
relation.scope({
        method: ["inTenant", tenantId]
      }).destory({
        where: {
          sourceId: sourceId,
          targetId: targetId,
        },
        individualHooks: true
      });
```


