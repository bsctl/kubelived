#!/bin/sh

FIRST_START="/tmp/keepalived-first-start"
if [ ! -e "$FIRST_START" ]; then
	echo $(date) $0: "keepalived first start"
	/usr/bin/config.sh /etc/keepalived/template.conf
	cp /etc/keepalived/template.conf /etc/keepalived/keepalived.conf
        touch $FIRST_START
fi
echo $(date) $0: "starting keepalived"
exec /usr/sbin/keepalived "$@" -f /etc/keepalived/keepalived.conf

# ---
# Credits: https://success.docker.com/article/use-a-script-to-initialize-stateful-container-data
# How do I initialize/seed data into my container at runtime, before the daemon process starts up in my container?
# There's a very common pattern used to initialize stateful data in a container at runtime.
# Use a shell script as the ENTRYPOINT of a container, and execute the necessary configurations before passing control to a long-running process.
# When the container starts up, the command portion is interprated to be sh -c 'keepalived.sh -nlPDd'.
# The script is invoked and given the argument -nlPDd.
# The script executes a series of instructions to configure keepalived properly.
# Finally, the exec shell construct is invoked, so that the final command given becomes the container's PID 1.
# $@ is a shell variable that means "all the arguments", so that leaves us with simply exec /usr/sbin/keepalived -nlPDd.
# The arguments -nlPDd can be overwritten when starting the container.
