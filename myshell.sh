#!/bin/bash

INSHOME=$HOME/.lima/default
PATH=/opt/homebrew/bin:/usr/sbin:$PATH

wait_ssh_ready () {
  while true; do
    nc -z 127.0.0.1 60022 &> /dev/null
    if [ $? = 0 ]; then
      return 0
    fi
    sleep 2
  done
}

wait_instance_ready () {
  while true; do
    local ready=$(tail -n1 ~/.lima/default/ha.stdout.log | jq .status.running)
    if [ true = $ready ]; then
      return 0
    fi
    sleep 2
  done
}

#echo "Wait for ssh ready"
wait_ssh_ready

#echo "Wait for instance ready"
wait_instance_ready

#echo "Starting shell"
lima

