#!/usr/bin/env bash

## GETS THE CURRENT MODULE ROOT DIRECTORY
MOD_MULTIBOT_BRIDGE_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

if [ -f $MOD_MULTIBOT_BRIDGE_ROOT"/conf/conf.sh.dist" ]; then
    source $MOD_MULTIBOT_BRIDGE_ROOT"/conf/conf.sh.dist"
fi

if [ -f $MOD_MULTIBOT_BRIDGE_ROOT"/conf/conf.sh" ]; then
    source $MOD_MULTIBOT_BRIDGE_ROOT"/conf/conf.sh"
fi
