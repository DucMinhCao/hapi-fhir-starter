#!/usr/bin/env bash

terraform apply -parallelism=1 -auto-approve -state=./.temp/state.tf -backup=./.temp/backup.tf
