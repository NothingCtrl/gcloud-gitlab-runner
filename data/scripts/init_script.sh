#!/bin/bash

if [[ ! -f /etc/gitlab-runner/config.toml ]]
then
    echo "Please register gitlab-runner..."
    tail -F /dev/null
else
    # nohup bash -c "gitlab-runner run" &
    gitlab-runner run
fi