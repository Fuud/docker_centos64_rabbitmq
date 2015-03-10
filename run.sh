#!/bin/bash
/etc/init.d/rabbitmq-server start &
/usr/sbin/sshd -D &
sleep `if [[ -z "$auto_exit_timeout" ]]; then echo infinity ; else echo $auto_exit_timeout ; fi`