#!/bin/sh

chown -R $uid:$gid /workspace
exec su-exec $uid:$gid npm -version