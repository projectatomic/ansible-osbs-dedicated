#!/bin/sh -x

rm -f tmp/*.yml
ansible-playbook --tags oc deploy.yml $@
