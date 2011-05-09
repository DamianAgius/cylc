#!/bin/bash

# cylc example suite, task F
# depends on task C

# run length 50 minutes

cylc task-started || exit 1

ACCEL=$(( 3600 / 10 )) # 10 s => 1 hour
SLEEP=$(( 50 * 60 / ACCEL )) 

# check prerequistes
PRE=$CYLC_TMPDIR/postproc/input/$CYCLE_TIME/forecast.nc
[[ ! -f $PRE ]] && {
    MSG="file not found: $PRE"
    echo "ERROR, postproc: $MSG"
    cylc task-failed $MSG
    exit 1
}

sleep $SLEEP 

OUTDIR=$CYLC_TMPDIR/postproc/output/$CYCLE_TIME
mkdir -p $OUTDIR
touch $OUTDIR/products.nc
cylc task-message "forecast products ready for $CYCLE_TIME"

cylc task-finished