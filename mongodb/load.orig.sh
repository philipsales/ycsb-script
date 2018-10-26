#!/bin/bash

#import
. settings/config.cfg

function loaddata() {
    COMMAND="load"

    DB=$1
    WORKLOAD=$2
    WORKLOAD_DIR=$3
    COUNTER=$4
    DAT_FILE=$5
    THROUGHPUT=$(echo "$DAT_FILE" | cut -f 1 -d '.')
    FILE_EXT="txt"
    RESULT_FILE=$WORKLOAD_DIR/$THROUGHPUT.$COMMAND-$COUNTER.$WORKLOAD.$FILE_EXT
    
    . settings/$DB.cfg
    cd $YCSB_BIN

    ./bin/ycsb $COMMAND $DB \
        -P workloads/workloada \
        -P $SETTINGS_DIR/$DAT_FILE \
        -s \
        -p $HOSTS \
        -p $PORT \
        > $RESULT_FILE \
        -src $DATA_DIR/$THROUGHPUT

    # data as bytes
    #./bin/ycsb $COMMAND $DB \
        #-P workloads/$WORKLOAD  \
        #-P $SETTINGS_DIR/$DAT_FILE \
        #-s \
        #-p $HOSTS \
        #-p $PORT \
        #> $RESULT_FILE 
}

#original command 
#./bin/ycsb load mongodb -P workloads/workloada \
  #-P /Users/ghost/src/github/YCSB-scripts/settings/1k.dat \
  #-p hosts=127.0.0.1 \
  #-p port=27017 \ 
  #-s  > ./output/result/mongodb/workloadi/1k.load-1.workloada.txt \
  #-src /Users/ghost/src/github/YCSB4/output/data/1k

