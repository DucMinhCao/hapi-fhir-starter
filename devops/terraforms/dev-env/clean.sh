#!/usr/bin/env bash

terraform destroy -parallelism=1 -state=./.temp/state.tf -backup=./.temp/backup.tf -auto-approve
