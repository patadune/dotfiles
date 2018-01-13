#!/bin/sh

export KEEAGENT_SOCK="/mnt/c/Users/remis/keeagent_msys.socket"

ssh_auth_tmpdir=`mktemp --tmpdir --directory keeagent-ssh.XXXXXXXXXX`
export SSH_AUTH_SOCK="${ssh_auth_tmpdir}/agent.$$"
PIDFILE="${ssh_auth_tmpdir}/pid.$$"

msysgit2unix-socket.py --pidfile $PIDFILE $KEEAGENT_SOCK:$SSH_AUTH_SOCK
