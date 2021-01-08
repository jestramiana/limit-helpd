#!/bin/zsh

LIMIT_SECONDS=$1
WAIT_TIME_SECONDS=$2
LOG_FILE=/tmp/limit_helpd.log

while true
do
        # Check whether there is a 'helpd' process running or not.
        HELPD_PID=$(pgrep helpd | head -n 1)
        if [ -n "$HELPD_PID" ]
        then
                # A process exists => Calculate its CPU time.
                HELPD_CPU_TIME=$(printf '%.*f\n' 0 `ps -p $HELPD_PID -o cputime 2> /dev/null | tail -n 1 | tr -d "TIME" | xargs | awk -F'[: ]+' '/:/ {t=$2+60*$1; print t}'`)

                # If this CPU is greater than the one configured, kill the process and add a log entry.
                if [ $HELPD_CPU_TIME -gt $LIMIT_SECONDS ]
                then
                        kill -15 $HELPD_PID && echo $(date) KILLED helpd pid=$HELPD_PID cputime=$HELPD_CPU_TIME limit=$LIMIT_SECONDS >> $LOG_FILE
                fi
        fi

        # Wait for some time until next check.
        sleep $WAIT_TIME_SECONDS
done
