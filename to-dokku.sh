#!/bin/bash

remote=`ENV_FILE=.env ./support/dokku-remote.sh`
local=`git branch | grep \* | cut -d ' ' -f2`

git add -A; git commit --amend --no-edit; git push ${remote} ${local}:master -f

git reset origin/${local}
