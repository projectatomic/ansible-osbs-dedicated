Playbook for deploying OSBS into [OpenShift Dedicated](https://www.openshift.com/dedicated/)
============================================================================================

1. Rename `config.yml.example` to `config.yml` and edit it to suit your needs.

2. Use `oc login` to log into your OpenShift instance.

3. Execute the `update-roles.sh` script to download roles that are used. You
   may need to do this whenever these roles change. If you are working on the
   roles it is recommended to ignore this script and instead symlink the roles
   repositories under the `roles/` directory.

4. Run `deploy.sh`. Any arguments will be passed to `ansible-playbook` - you
   might want to use e.g. `--verbose`.


Requirements for self-hosted OSE instance
=========================================

A bare self-hosted OSE installation should be sufficient for OSBS to work,
as it doesn't require routers, docker registry or SDN to function.


Role Variables
==============

Specify project namespace
```
osbs_namespace: best-namespace
```

Create service accounts

Depending on your configuration OSBS needs to setup service accounts 
to allow various services (e.g. koji) to communicate with OSBS.
```
osbs_service_accounts:
  - koji
```

Set permissions for users
```
osbs_readonly_users: []
osbs_readonly_groups: []
osbs_readwrite_users:
  - system:serviceaccount:{{ osbs_namespace }}:koji
  - system:serviceaccount:{{ osbs_namespace }}:builder
osbs_readwrite_groups:
  - system:authenticated
osbs_admin_users: []
osbs_admin_groups: []
```

Set maximum number of simultaneous builds
```
osbs_master_max_pods: -1
```

Skip errors on importing secrets, if those are not required
```
osbs_secret_can_fail: true
```

Create Openshift secrets for pulp, reading certification from local dir
```
pulp_secret_local_dir: /home/user/.pulp
pulp_secret_name: pulpsecret
```

Koji credentials setup
```
koji_secret_local_dir: /home/user/directory-with-koji-certificates
koji_secret_name: kojisecret
```

V2 registry credentials (.dockercfg)

Specify the path to the local JSON-formatted .dockercfg file, and the name of the Kubernetes secret that will be created to hold it.

```
v2_registry_secret_local_file: /home/user/.dockercfg
v2_registry_secret_name: v2-registry-dockercfg
```

Hardcoded vars
==============

The following vars are used in other roles:

Set environment variables (e.g. http_proxy) to be used for some commands
```
osbs_environment: {}
```

Temporary folder to store files: e.g. generated configs
```
osbs_openshift_home: /tmp
```

Temporary folder to store generated secret files (will be cleaned up on exit)
```
osbs_secret_remote_dir: "{{ osbs_openshift_home }}"
```