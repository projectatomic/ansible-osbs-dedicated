#!/bin/sh -x

rm -f tmp/*.yml
ansible-playbook --tags oc --skip-tags resourcequotas deploy.yml $@
