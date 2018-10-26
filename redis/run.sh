#!/bin/bash

#import
. settings/config.cfg

function runtask() {
    OUTPUT_DIR=$1
    DB=$2
    COUNTER=$3
    DAT_FILE=$4
    WORKLOAD=$5

    WORKLOAD_DIR="$OUTPUT_DIR/$WORKLOAD"
    mkdir -p $WORKLOAD_DIR

    COMMAND="run"
    THROUGHPUT=$(echo "$DAT_FILE" | cut -f 1 -d '.')
    FILE_EXT="txt"
    RESULT_FILE=$WORKLOAD_DIR/$THROUGHPUT.$COMMAND-$COUNTER.$WORKLOAD.$FILE_EXT

    
    . $SETTINGS_DIR/$DB.cfg
    cd $YCSB_BIN

    echo '---start script----'
    echo "$COMMAND $DB  -P workloads/workloada -P $SETTINGS_DIR/$DAT_FILE -s -p $HOSTS  -p $PORT  > $RESULT_FILE  -src $DATA_DIR" 
    echo '---end script----'

    ./bin/ycsb $COMMAND $DB \
        -P workloads/$WORKLOAD  \
        -P $SETTINGS_DIR/$DAT_FILE \
        -s \
        -p $HOSTS \
        -p $PORT \
        > $RESULT_FILE \
        -src $DATA_DIR
        #-src $DATA_DIR/$THROUGHPUT
}
