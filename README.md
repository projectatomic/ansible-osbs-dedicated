Playbook for deploying OSBS into [OpenShift Dedicated](https://www.openshift.com/dedicated/)
============================================================================================

1. Rename `vars.yml.example` to `vars.yml` and edit it to suit your needs.

2. Use `oc login` to log into your OpenShift instance.

3. Execute the `update-roles.sh` script to download roles that are used. You
   may need to do this whenever these roles change. If you are working on the
   roles it is recommended to ignore this script and instead symlink the roles
   repositories under the `roles/` directory.

4. Run `deploy.sh`. Any arguments will be passed to `ansible-playbook` - you
   might want to use e.g. `--verbose`.
