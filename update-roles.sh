#!/bin/sh -x

rm -rf roles/*
ansible-galaxy install -r rolesfile.yml -p roles/
