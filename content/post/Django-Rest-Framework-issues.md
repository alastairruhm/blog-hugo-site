+++
title = "Django Rest Framework 问题备忘"
date = "2016-08-16"
tags = ["django-rest-framework"]
+++

# Django Rest Framework 问题备忘


### API 列表数据的组合


参考：

https://github.com/openstack/horizon/blob/master/openstack_dashboard/dashboards/admin/instances/views.py


```
# Gather our flavors to correlate against IDs
  try:
      flavors = api.nova.flavor_list(self.request)
  except Exception:
      # If fails to retrieve flavor list, creates an empty list.
      flavors = []

  full_flavors = OrderedDict([(f.id, f) for f in flavors])
  tenant_dict = OrderedDict([(t.id, t) for t in tenants])
  # Loop through instances to get flavor and tenant info.
  for inst in instances:
      flavor_id = inst.flavor["id"]
      try:
          if flavor_id in full_flavors:
              inst.full_flavor = full_flavors[flavor_id]
          else:
              # If the flavor_id is not in full_flavors list,
              # gets it via nova api.
              inst.full_flavor = api.nova.flavor_get(
                  self.request, flavor_id)
      except Exception:
          msg = _('Unable to retrieve instance size information.')
          exceptions.handle(self.request, msg)
      tenant = tenant_dict.get(inst.tenant_id, None)
      inst.tenant_name = getattr(tenant, "name", None)

```

### Nested resource routers 

参考 repo

[alanjds/drf-nested-routers: Nested Routers for Django Rest Framework](https://github.com/alanjds/drf-nested-routers)

但是注意这个第三方库不稳定


