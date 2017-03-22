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

