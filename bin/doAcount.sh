#!/bin/bash
#
CUT_DAY=23
MAX_AMT=10000
LOG_HOME=/home/ec2-user/log
MLOG_FILE=$LOG_HOME/money.log
SLOG_FILE=$LOG_HOME/lastSum.log
LOCK_FILE=$LOG_HOME/newPeriod.lck
PUSH_NOTE="/home/ec2-user/Downloads/pushbullet-bash/pushbullet push all note"
TODAY=$(date +%-d)
# Initial validations
if [[ $(cat "$MLOG_FILE" | grep "Retiro" | wc -c) -eq 0 ]]; then
    # Deposito or something else
    exit 0
fi
if [[ $(cat "$MLOG_FILE" | grep "Cuenta.*223" | wc -c) -eq 0 ]]; then
    # Not CC
    exit 0
fi
if [[ $(cat "$MLOG_FILE" | grep "Importe" | wc -c) -eq 0 ]]; then
    # Nothing to do
    exit 0
fi
# Current amount, look for $ and then for ., delete all commas
AMOUNT=$(cat $MLOG_FILE | grep "Importe" | cut -d$ -f2 | cut -d. -f1 | tr -d ,)
SUM=$(tail -n 1 $SLOG_FILE)
# Check the day of the month
if (( TODAY > CUT_DAY ));
then
    if [ ! -e $LOCK_FILE ]; # New period
    then
        # No need to sumo 
        DATE=$(date +%F)
        echo "==== New period $DATE ====" >> $SLOG_FILE
        touch $LOCK_FILE;
    else
        AMOUNT=$((AMOUNT + SUM ))
    fi
else
    # Add to existing sum
    AMOUNT=$((AMOUNT + SUM ))
    if [ -e $LOCK_FILE ]; # New period
    then
        rm $LOCK_FILE;
    fi
fi
echo $AMOUNT >> $SLOG_FILE;
if (( AMOUNT > MAX_AMT ));
then
    # Send notification
    $PUSH_NOTE "CC Limit reached: \$$AMOUNT" &
fi
